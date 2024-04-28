import 'package:flutter/material.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_bar.dart';
import 'package:tareegoff22/presentation/widgets/admin_list_view_item.dart';
import 'package:tareegoff22/presentation/widgets/admin_list_view_content.dart';

class AdminComplainesScreen extends StatefulWidget {
  const AdminComplainesScreen({Key? key,  this.catId}) : super(key: key);
 final String? catId;
  @override
  State<AdminComplainesScreen> createState() => _AdminComplainesScreenState();
}

class _AdminComplainesScreenState extends State<AdminComplainesScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    
      appBar: CustomAppBar(' الإبلاغات', Icons.supervised_user_circle_outlined),
      body: Column(
        children: [
          CustomListViewImage(catId: widget.catId,),
          Divider(
            height: 3,
            color: Colors.grey.withOpacity(0.1),
            thickness: 2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.020,
          ),
          Expanded(
            child: CustomListViewContent(
              catId:widget.catId ,
            ),
          )
        ],
      ),
    );
  }
}
