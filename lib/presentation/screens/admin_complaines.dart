import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_bar.dart';
import 'package:tareegoff22/presentation/widgets/admin_list_view_item.dart';
import 'package:tareegoff22/presentation/widgets/admin_list_view_content.dart';

class AdminComplainesScreen extends StatelessWidget {
  const AdminComplainesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(' الإبلاغات', Icons.supervised_user_circle_outlined),
      body: Column(
        children: [
          CustomListViewItem(),
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
              imgUrl: [
                'assets/images/kh1.jpg',
                'assets/images/kh2.jpg',
                'assets/images/kh5.jpg',
                'assets/images/kh1.jpg',
                'assets/images/kh2.jpg',
                'assets/images/kh5.jpg',
              ],
              places: ['القطن', 'سيئون', 'تريم', 'القطن', 'سيئون', 'تريم'],
            ),
          )
        ],
      ),
    );
  }
}
