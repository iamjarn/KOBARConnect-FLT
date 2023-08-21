import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobar/UI/Models/Header.dart';
import 'package:kobar/UI/Widget/loadingWidget.dart';
import 'package:kobar/Utility/Theme.dart';
import 'package:kobar/bloc/header_bloc.dart';
import 'package:video_player/video_player.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  CarouselController carouselController = CarouselController();
  VideoPlayerController? _controller;
  Timer? timer;
  bool isTimerStart = false;
  int currentTimer = 0;
  int timerHeaderPerPageInSeconds = 5;
  List<Header> list_Header = [];
  bool alreadyCheckHeader = false;
  int current_page = 0;

  @override
  void initState() {
    super.initState();
    // checkFirstHeader();
  }

  void checkFirstHeader() {
    if (list_Header.length > 0) {
      Header data = list_Header[0];
      if (data.header_type == "VIDEO") {
        initializeVideoController(data.type == "asset", data.value);
      } else {
        print("start");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          startTimer();
        });
      }
    }
  }

  void initializeVideoController(bool is_asset, String url) {
    var video_controller = VideoPlayerController.network(url);
    _controller = video_controller
      ..initialize().then((_) {
        _controller!.addListener(() {
          if (!_controller!.value.isPlaying &&
              _controller!.value.isInitialized &&
              (_controller!.value.duration == _controller!.value.position)) {
            carouselController.nextPage();
          }
        });

        _controller!.setVolume(0);
        setState(() {
          _controller!.play();
        });
      });
  }

  void onHeaderPageChange(index) {
    stopTimer();
    Header data = list_Header[index];

    if (_controller != null) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      }
    }

    if (data.header_type == "VIDEO") {
      initializeVideoController(data.type == "asset", data.value);
    } else {
      startTimer();
    }
  }

  void startTimer() {
    print("timer status ${isTimerStart}");
    print("time ${currentTimer}");
    setState(() {
      isTimerStart = true;
    });
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTimer++;
        if (currentTimer == timerHeaderPerPageInSeconds) {
          GoNextPage();
        }
      });
    });
  }

  void GoNextPage() {
    stopTimer();
    carouselController.nextPage();
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
      setState(() {
        currentTimer = 0;
        isTimerStart = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller!.dispose();
    }
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screen_height = MediaQuery.of(context).size.height;
    double header_height = (screen_height * 35 / 100);

    return Container(
      child: SafeArea(
          bottom: false,
          child: Container(
            height: header_height,
            width: double.infinity,
            child: BlocBuilder<HeaderBloc, HeaderState>(
              builder: (context, state) {
                if (state is HeaderUninitialized) {
                  return LoadingWidget();
                } else {
                  HeaderLoaded headerLoaded = state as HeaderLoaded;
                  list_Header = headerLoaded.headers;
                  if (!alreadyCheckHeader) {
                    alreadyCheckHeader = true;
                    checkFirstHeader();
                  }
                  return Stack(
                    children: [
                      Container(
                          height: header_height,
                          width: double.infinity,
                          child: CarouselSlider(
                            carouselController: carouselController,
                            options: CarouselOptions(
                                height: header_height,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                                enableInfiniteScroll: true,
                                onPageChanged: (index, reason) {
                                  onHeaderPageChange(index);
                                }),
                            items: list_Header.map((header) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration:
                                          BoxDecoration(color: black_color),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: header_height,
                                            padding:
                                                EdgeInsets.only(bottom: 15),
                                            child: header.header_type == "IMAGE"
                                                ? Image.network(
                                                    header.value,
                                                    fit: BoxFit.cover,
                                                  )
                                                : _controller != null
                                                    ? _controller!
                                                            .value.isInitialized
                                                        ? AspectRatio(
                                                            aspectRatio:
                                                                _controller!
                                                                    .value
                                                                    .aspectRatio,
                                                            child: VideoPlayer(
                                                                _controller!),
                                                          )
                                                        : Container()
                                                    : Container(),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: header_height * 18 / 100,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      end: Alignment.center,
                                                      begin:
                                                          Alignment.topCenter,
                                                      colors: [
                                                    Colors.transparent,
                                                    grey_color,
                                                  ])),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              width: double.infinity,
                                              height: header_height,
                                              padding:
                                                  EdgeInsets.only(bottom: 30),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "Selamat Datang di Kotawaringin Barat",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontFamily: "Asap")),
                                                  Text(
                                                    header.description,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                                },
                              );
                            }).toList(),
                          )),
                      // Align(
                      //   alignment: Alignment.topCenter,
                      //   child: Padding(
                      //     padding: EdgeInsets.only(top: 10),
                      //     child: Image.asset("images/pasuruan.png"),
                      //   ),
                      // )
                    ],
                  );
                }
              },
            ),
          )),
    );
  }
}
