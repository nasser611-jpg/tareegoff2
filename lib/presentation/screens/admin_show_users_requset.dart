import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_bar.dart';
import 'package:tareegoff22/presentation/screens/admin_complaines.dart';

class AdminShowUsers extends StatefulWidget {
  const AdminShowUsers({Key? key}) : super(key: key);

  @override
  State<AdminShowUsers> createState() => _AdminShowUsersState();
}

class _AdminShowUsersState extends State<AdminShowUsers> {
  List<DocumentSnapshot> data=[];
  bool isLoading=true;
  
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .get();

    Set<String> emails = {}; // Store unique emails

    for (var doc in querySnapshot.docs) {
      String email = doc['email'];
      if (!emails.contains(email)) { // Check if the email already exists
        data.add(doc);
        emails.add(email); // Add the email to the set
      }
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(' المستخدمين', Icons.people_sharp),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder:(context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) {
                return AdminComplainesScreen(catId:data[index]['id'],);
              },));
            },
            child: Container(height: 100,width: 250,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 141, 161, 151).withOpacity(0.3),width: 3),
                borderRadius: BorderRadius.circular(12),

              ),
              child:Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(backgroundColor:const Color.fromARGB(255, 130, 176, 154),maxRadius: 40,
                    child:   Image.asset('assets/images/person.png',width: 30,height: 40,),
                  ),
                  const SizedBox(width: 20,),
                  Column(children: [
                    
                    Row(
                      children: [ 
                        Text( data[index]['displayName'],style: Styles.textStyle12,textAlign: TextAlign.left,),
                       Text('   : مقدم الطلب  ',),
                      ],
                    ),
                    Text(
  data[index]['email'],
  style: const TextStyle(fontSize: 17),
  softWrap: true,
  overflow: TextOverflow.visible,
  maxLines: 2, 
)

                  ],)
                ],
              ),
            ),
          );
        },),
    );

  }
}