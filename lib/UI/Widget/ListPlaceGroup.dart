import 'package:flutter/material.dart';
import 'package:kobar/UI/Models/Place.dart';
import 'package:kobar/UI/Pages/DetailCategory.dart';
import 'package:kobar/UI/Pages/DetailPage.dart';
import 'package:kobar/UI/Widget/PlaceCard.dart';

class ListPlaceGroup extends StatefulWidget {
  final String list_title;
  final List<Place> list_item;
  final int category_id;

  ListPlaceGroup(
      {Key? key,
      required this.list_title,
      required this.list_item,
      required this.category_id});

  @override
  State<ListPlaceGroup> createState() => _ListPlaceGroupState();
}

class _ListPlaceGroupState extends State<ListPlaceGroup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            widget.list_title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.black,
                fontFamily: 'Axiforma'),
          ),
        ),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == widget.list_item.length - 1) {
                return Row(
                  children: [
                    Container(
                      height: 150,
                      child: PlaceCard(
                          onClick: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (contenxt) {
                              return DetailPage(place: widget.list_item[index]);
                            }));
                          },
                          place: widget.list_item[index]),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailCategory(
                            category_title: widget.list_title,
                            category_id: widget.category_id,
                          );
                        }));
                      },
                      child: Container(
                        height: 220,
                        width: 100,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_forward),
                              Text("Click for more places")
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Padding(
                  padding: index == 0
                      ? EdgeInsets.only(left: 18)
                      : EdgeInsets.all(0),
                  child: PlaceCard(
                      onClick: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (contenxt) {
                          return DetailPage(place: widget.list_item[index]);
                        }));
                      },
                      place: widget.list_item[index]),
                );
              }
            },
            itemCount: widget.list_item.length,
          ),
        ),
        SizedBox(
          height: 12,
        )
      ],
    );
  }
}
