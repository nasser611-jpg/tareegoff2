import 'package:flutter/material.dart';
import 'package:tareegoff22/core/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tareegoff22/presentation/widgets/custom_animate_dots.dart';

class CustomListViewImage extends StatefulWidget {
  const CustomListViewImage({super.key, this.catId});
  final String? catId;
  @override
  // ignore: library_private_types_in_public_api
  _CustomListViewImageState createState() => _CustomListViewImageState();
}

class _CustomListViewImageState extends State<CustomListViewImage> {


  int _currentIndex = 0;
 bool isLoading=true;
 List<QueryDocumentSnapshot> data=[];
getData()async{
  QuerySnapshot querySnapshot=
 await FirebaseFirestore.instance
    .collection('categories').doc( widget.catId).collection('note').get();
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
    return isLoading?const Center(child: CircularProgressIndicator(),): Container(
      width: 370,
      height: MediaQuery.of(context).size.height * 0.250,
      padding: const EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
      child: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
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
                          width: 1, color: const Color.fromARGB(255, 80, 160, 226)),
                     image: DecorationImage(
                          image:data[index]['url']!=null? NetworkImage(
                            data[index]['url'],
                          ):NetworkImage(imgUrl),
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
              itemCount: data.length,
            ),
          ),
        ],
      ),
    );
  }
}
