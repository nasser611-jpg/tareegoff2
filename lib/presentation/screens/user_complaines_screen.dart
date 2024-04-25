import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    List<QueryDocumentSnapshot> data=[];
  bool isLoading=true;

getData()async{
  QuerySnapshot querySnapshot=
 await FirebaseFirestore.instance
    .collection('categories').doc( FirebaseAuth.instance.currentUser!.uid).collection('note').get();
    data.addAll(querySnapshot.docs);
    isLoading=false;
setState(() {
  
});
}
  @override
  void initState() {
   getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(onPressed:() {
           Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const UserSendComplainesScreen();
                                },
                              ));
      },child: const Icon(Icons.add_comment),),
      appBar: CustomAppBar('طلباتي', Icons.account_circle,type: 'no'),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child:isLoading?const Center(child: CircularProgressIndicator()) : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {try{ Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return GoogleMapsScreen(
                                      lan: data[index]['lat'],
                                      long: data[index]['long']);
                                },
                              ));}catch(e){
                                AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: true,
                      title: 'عذرا',
                      desc:
                          'الرجاء التاكد من جودة الانتنرنت  لديك !...'   ,btnOkOnPress: () {
                         
                          },
                          btnOkText: 'حسناً'
                   
                    ).show();
                              }
                    
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
                          const SizedBox(
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
                          const Spacer(),
                          Container(
                            height: 22,
                            width: 88,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: data[index]['state'] == 'مقبول'
                                    ? const Color.fromARGB(255, 81, 237, 161)
                                    : data[index]['state']== 'مرفوض'
                                        ? const Color.fromARGB(255, 239, 105, 105)
                                        : const Color.fromARGB(255, 234, 190, 115)),
                            child: Text(
                             data[index]['state'],
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
                           Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '${FirebaseAuth.instance.currentUser!.displayName}',
                                  style: Styles.textStyle12,
                                ),
                              ),
                              Text(
                                'مقدم الطلب : ',
                                textDirection: TextDirection.rtl,
                              )
                            ],
                          ),
                          const Spacer(),
                          Text(
                            data[index]['time'],
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
