import 'package:flutter/material.dart';
import 'package:tareegoff22/core/utils.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:tareegoff22/presentation/screens/admin_content_details.dart';
// Your styles file

class CustomListViewContent extends StatefulWidget {
  final List<String> imgUrl;
  final List<String> places;

  CustomListViewContent({
    Key? key,
    required this.imgUrl,
    required this.places,
  }) : super(key: key);

  @override
  State<CustomListViewContent> createState() => _CustomListViewContentState();
}

class _CustomListViewContentState extends State<CustomListViewContent> {
  Map<int, String> selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.imgUrl.length,
      itemBuilder: (context, index) {
        selectedValues[index] = selectedValues[index] ?? 'قيد المراجعه';

        return Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(6),
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
                      date: formattedDateTime,
                      imgUrl: widget.imgUrl[index],
                      decription:
                          ' .هذا العطل موجود منذ ما يقارب 3 سنوات وادى الى نشوب كثير من الحوادث, نرجوا منكم القيام باصلاحه .',
                      lan: 15.950262265581308,
                      long: 48.80959580167567);
                },
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment:
                      CrossAxisAlignment.end, // Align text to the right
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Text(
                            widget.places[
                                index], // Access restaurant name from the list
                            style: Styles.textStyle12.copyWith(fontSize: 16),
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.greenAccent,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PopupMenuButton<String>(
                          onSelected: (String value) {
                            // Update the selected value for this item
                            setState(() {
                              selectedValues[index] = value;
                            });
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
                                color: selectedValues[index] == 'مرفوض'
                                    ? Colors.red
                                    : selectedValues[index] == 'مقبول'
                                        ? Color.fromARGB(245, 3, 165, 105)
                                        : Color.fromARGB(255, 50, 122, 87),
                                borderRadius: BorderRadius.circular(15)),
                            alignment: Alignment.center,
                            child: Text(
                              selectedValues[
                                  index]!, // Use the selected value for this item
                              textAlign: TextAlign.center,
                              style: Styles.textStyle12
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 37),
                        Row(
                          children: [Text(formattedDateTime)],
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
                      image: AssetImage(widget.imgUrl[index]),
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
  }
}
