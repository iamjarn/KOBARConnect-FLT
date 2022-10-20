import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobar/UI/Models/Category.dart';
import 'package:kobar/UI/Widget/HomeHeader.dart';
import 'package:kobar/UI/Widget/ListPlaceGroup.dart';
import 'package:kobar/UI/Widget/loadingWidget.dart';
import 'package:kobar/Utility/Theme.dart';
import 'package:kobar/bloc/recommend_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey_color,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(),
            BlocBuilder<RecommendBloc, RecommendState>(
                builder: (context, state) {
              if (state is RecommendUninitialized) {
                return LoadingWidget();
              } else if (state is RecommendLoaded) {
                RecommendLoaded recommendLoaded = state as RecommendLoaded;
                List<Category> data = recommendLoaded.recommends;
                return Column(
                  children: data.map((e) {
                    return ListPlaceGroup(
                      list_title: "Rekomendasi ${e.name}",
                      list_item: e.list_tour,
                      category_id: e.id,
                    );
                  }).toList(),
                );
              } else {
                return Center(
                  child: Text("kosong"),
                );
              }
            }),
            SizedBox(
              height: 75,
            )
          ],
        ),
      ),
    );
  }
}
