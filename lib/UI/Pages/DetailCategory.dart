import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobar/UI/Models/Place.dart';
import 'package:kobar/UI/Pages/DetailPage.dart';
import 'package:kobar/UI/Widget/loadingWidget.dart';
import 'package:kobar/Utility/Theme.dart';
import 'package:kobar/bloc/category_bloc.dart';

class DetailCategory extends StatefulWidget {
  final String category_title;
  final int category_id;
  const DetailCategory(
      {required this.category_title, required this.category_id, Key? key})
      : super(key: key);

  @override
  State<DetailCategory> createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  List<String> list_item = ["1", '2', '3'];

  @override
  void initState() {
    // TODO: implement initState
    context
        .read<CategoryBloc>()
        .add(getPlaceByCategories(category_id: widget.category_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey_color,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          widget.category_title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        if (state is CategoryUninitialized) {
          return LoadingWidget();
        } else if (state is CategoryLoading) {
          return LoadingWidget();
        } else if (state is CategoryLoaded) {
          return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            childAspectRatio: (150 / 220),
            children: state.places.map((Place value) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailPage(place: value);
                  }));
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            value.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  end: Alignment.center,
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ])),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            value.name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
