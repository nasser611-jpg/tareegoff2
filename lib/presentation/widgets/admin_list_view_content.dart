import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tareegoff22/presentation/screens/admin_content_details.dart';
// Your styles file

class CustomListViewContent extends StatefulWidget {
  final String? catId;
  CustomListViewContent({
    Key? key,
    this.catId,
  }) : super(key: key);

  @override
  State<CustomListViewContent> createState() => _CustomListViewContentState();
}

class _CustomListViewContentState extends State<CustomListViewContent> {
  Map<int, String> selectedValues = {};
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.catId)
        .collection('note')
        .get();
    data.addAll(querySnapshot.docs);
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
    return StreamBuilder(
 
  stream: FirebaseFirestore.instance
      .collection('categories')
      .doc(widget.catId)
      .collection('note')
      .snapshots(),
  builder: (context, snapshot) {
    
   {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator(); // or any other loading indicator
    }

    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    List<DocumentSnapshot> data = snapshot.data!.docs;
    List<String> selectedValues = List<String>.filled(data.length, '');

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        selectedValues[index] = data[index]['state'] ?? 'قيد المراجعه';

        return Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(6),
          height: 90,
          width: 320,
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(
                style: BorderStyle.solid, color: Colors.grey.withOpacity(0.6))),
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AdminContentDetails(
                      date: data[index]['time'],
                      imgUrl: data[index]['url'],
                      decription: data[index]['des'],
                      lan: data[index]['lat'],
                      long: data[index]['long']);
                },
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Container(
                            height: 30,width: 150,
                            child: Text(
                              data[index]['address'],softWrap: true,
                              style: Styles.textStyle12.copyWith(fontSize: 10),
                            ),
                          ),
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.greenAccent,
                            size: 35,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PopupMenuButton<String>(
                          onSelected: (String value) async {
                            selectedValues[index] = value;
                            try {
                              CollectionReference collNote = FirebaseFirestore
                                  .instance
                                  .collection('categories')
                                  .doc(widget.catId)
                                  .collection('note');

                              await collNote
                                  .doc(data[index].id)
                                  .update({'state': value});
                     
                            } catch (e) {}

                            setState(() {});
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                value: 'مقبول',
                                child: Text('مقبول',
                                    style: Styles.textStyle12
                                        .copyWith(color: Colors.black)),
                              ),
                              PopupMenuItem(
                                value: 'مرفوض',
                                child: Text('مرفوض',
                                    style: Styles.textStyle12
                                        .copyWith(color: Colors.black)),
                              ),
                            ];
                          },
                          child: Container(
                            width: 90,
                            height: 20,
                            decoration: BoxDecoration(
                                color: selectedValues[index] == 'مرفوض' ||
                                        data[index]['state'] == 'مرفوض'
                                    ? Colors.red
                                    : selectedValues[index] == 'مقبول' ||
                                            data[index]['state'] == 'مقبول'
                                        ? const Color.fromARGB(245, 3, 165, 105)
                                        : const Color.fromARGB(255, 50, 122, 87),
                                borderRadius: BorderRadius.circular(15)),
                            alignment: Alignment.center,
                            child: Text(
                              data[index]['state'],
                              textAlign: TextAlign.center,
                              style: Styles.textStyle12
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 64),
                        Row(
                          children: [Text(data[index]['time'],style:const TextStyle(fontSize: 11) ,)],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 80,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(data[index]['url']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }}
);
 }
}
