import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kobar/UI/Models/Place.dart';
import 'package:kobar/UI/Pages/OrderPage.dart';
import 'package:kobar/UI/Pages/WebviewPage.dart';

class DetailPage extends StatefulWidget {
  final Place place;

  const DetailPage({Key? key, required this.place}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  CarouselController header_controller = new CarouselController();
  int current_page = 0;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screen_height = MediaQuery.of(context).size.height;
    var screen_width = MediaQuery.of(context).size.width;
    double header_height = (screen_height * 35 / 100);

    var list_image = widget.place.images;
    double padding = 24;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          widget.place.name!,
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        height: screen_height - (AppBar().preferredSize.height),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    carouselController: header_controller,
                    options: CarouselOptions(
                        height: header_height,
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            current_page = index;
                          });
                        }),
                    items: list_image.map((e) {
                      print("check Image ${e}");
                      return Container(
                        height: header_height,
                        width: double.infinity,
                        child: Image.network(
                          e!,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    for (int index = 0; index < list_image.length; index++)
                      Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: current_page == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.place.name!,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          widget.place.category.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Alamat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        widget.place.address ?? "-",
                        style: TextStyle(fontSize: 14),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Waktu Operasional",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        widget.place.operational_days ?? "-",
                        style: TextStyle(fontSize: 14),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      widget.place.description!,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppBar().preferredSize.height,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          String? homeLat = widget.place.latitude;
                          String? homeLng = widget.place.longitude;
                          var url = '';
                          if (Platform.isAndroid) {
                            url =
                                "https://www.google.com/maps/search/?api=1&query=${homeLat},${homeLng}";
                          } else {
                            url =
                                "https://www.google.com/maps/search/?api=1&query=${homeLat},${homeLng}";
                          }
                          // load_maps(url);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WebviewPage(
                              url: url,
                            );
                          }));
                        },
                        child: Container(
                          width: widget.place.category.is_enable_ticket
                              ? (screen_width / 2)
                              : screen_width,
                          height: double.infinity,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              "Get Direction",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      widget.place.category.is_enable_ticket
                          ? InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return OrderPage(place: widget.place);
                                }));
                              },
                              child: Container(
                                width: screen_width / 2,
                                height: double.infinity,
                                color: Colors.orange,
                                child: Center(
                                  child: Text(
                                    "Book Order",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox()
                    ],
                  )),
            )
          ],
        ),
      )),
    );
  }
}
