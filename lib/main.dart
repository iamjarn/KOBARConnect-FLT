import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobar/UI/Pages/SplashScreen.dart';
import 'package:kobar/Utility/Theme.dart';
import 'package:kobar/bloc/category_bloc.dart';
import 'package:kobar/bloc/header_bloc.dart';
import 'package:kobar/bloc/order_bloc.dart';
import 'package:kobar/bloc/recommend_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                HeaderBloc(HeaderUninitialized())..add(getContents()),
          ),
          BlocProvider(
            create: (_) =>
                RecommendBloc(RecommendUninitialized())..add(getRecommend()),
          ),
          BlocProvider(
            create: (_) => CategoryBloc(CategoryUninitialized()),
          ),
          BlocProvider(
            create: (_) => OrderBloc(OrderUninitialized()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme:
                AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
            fontFamily: 'Axiforma',
            primaryColor: grey_color,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            appBarTheme:
                AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
            fontFamily: 'Axiforma',
            primaryColor: grey_color,
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.light,
          home: SplashScreen(),
        ));
  }
}
