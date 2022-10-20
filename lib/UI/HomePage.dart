import 'package:flutter/material.dart';
import 'Pages/MainPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = new TabController(vsync: this, length: 1);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Image.asset(
          'images/kobar.png',
          fit: BoxFit.cover,
          width: 100,
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                MainPage(),
              ]),
        ],
      ),
    );
  }
}
