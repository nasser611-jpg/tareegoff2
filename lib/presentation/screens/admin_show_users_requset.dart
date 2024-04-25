import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:tareegoff22/presentation/screens/admin_complaines.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_bar.dart';

class AdminShowUsers extends StatefulWidget {
  const AdminShowUsers({Key? key}) : super(key: key);

  @override
  State<AdminShowUsers> createState() => _AdminShowUsersState();
}

class _AdminShowUsersState extends State<AdminShowUsers> {
    List<QueryDocumentSnapshot> data=[];
  bool isLoading=true;
getData()async{
  QuerySnapshot querySnapshot=
 await FirebaseFirestore.instance
    .collection('categories')
    .get();

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
      appBar: CustomAppBar('اصحاب الشكاوي', Icons.people_sharp),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder:(context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) {
              return AdminComplainesScreen();
            },));
          },
          child: Container(height: 80,width: 250,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4),
          
          ),
          child:Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             CircleAvatar(backgroundColor: Color.fromARGB(255, 130, 176, 154),maxRadius: 40,
            child:   Icon(Icons.person_pin,size: 40,),
             ),
              SizedBox(width: 20,),
              Column(children: [Text('nasser alobthani ',style: Styles.textStyle12,textAlign: TextAlign.left,
              
              ),
              Text('nasseroffcial@gmail.com',style: TextStyle(fontSize: 20))
              ],)
            ],
          ),
          ),
        );
      },),
    );

  }
}