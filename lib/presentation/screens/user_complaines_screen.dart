import 'package:flutter/material.dart';
import 'package:tareegoff22/core/utils.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:tareegoff22/presentation/widgets/custom_drawer.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_bar.dart';
import 'package:tareegoff22/presentation/screens/google_map_screen.dart';
import 'package:tareegoff22/presentation/screens/user_send_complaines.dart';

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
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(onPressed:() {
           Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return UserSendComplainesScreen();
                                },
                              ));
      },child: Icon(Icons.add_comment),),
      appBar: CustomAppBar('طلباتي', Icons.account_circle,type: 'no'),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: comp.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                     Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return GoogleMapsScreen(
                                      lan: 15.840799375481271,
                                      long: 48.46553424859829);
                                },
                              ));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  height: MediaQuery.of(context).size.height * 0.099,
                  width: MediaQuery.of(context).size.width * 0.850,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                          color:
                              const Color.fromARGB(255, 216, 115, 115).withOpacity(0.2),
                          width: 2)),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: const Row(
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
                          const Spacer(),
                          Container(
                            height: 22,
                            width: 88,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: comp[index] == 'مقبول'
                                    ? const Color.fromARGB(255, 81, 237, 161)
                                    : comp[index] == 'مرفوض'
                                        ? const Color.fromARGB(255, 239, 105, 105)
                                        : const Color.fromARGB(255, 234, 190, 115)),
                            child: Text(
                              comp[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color.fromARGB(212, 83, 69, 47)),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Row(
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
                          const Spacer(),
                          Text(
                            formattedDateTime,
                            style: const TextStyle(fontSize: 11),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
