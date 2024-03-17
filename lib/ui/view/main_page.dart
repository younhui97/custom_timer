import 'dart:math';
import 'dart:ui';
import 'package:custom_timer/model/mytimer.dart';
import 'package:custom_timer/ui/etcstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../colorstyle.dart';
import '../textstyle.dart';
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:string_2_icon/string_2_icon.dart';
import 'package:page_transition/page_transition.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  ValueNotifier<List<MyTimer>> timeListNotifier = ValueNotifier([]);
  ValueNotifier<int> selectedTimerIndexNotifier = ValueNotifier(0);
  ValueNotifier<String> newtimericonNotifier = ValueNotifier('questionb');
  List<MyTimer> _timerLista = [
    MyTimer(
        ticon: 'remove',
        name: 'Name',
        ison: false,
        tnamelist: ['1 mile run',
          '50 pushups',
          '100 air squats',
          '1 mile run'],
        tlengthlist: [],
        colors: ColorStyles.randomcolorlist[0])
  ];
  int _counter = 0;
  late Timer _timer;
  bool _isTimerRunning = false;
  String timername = '';
  String iconname = 'remove';
  bool isselected = false;
  List<String> iconlist = ['bicycle', 'book', 'cook', 'swim', 'yoga'];

  @override
  void initState() {
    _initRequiredDataList();
    super.initState();
  }

  void _initRequiredDataList() {
    timeListNotifier.value = List<MyTimer>.from([
      MyTimer(
          ticon: 'book',
          name: 'Toeic',
          ison: false,
          tnamelist: [
            '1 mile run',
            '50 pushups',
            '100 air squats',
            '1 mile run'
          ],
          tlengthlist: [10 * 60, 20 * 60, 20 * 60, 10 * 60],
          colors: ColorStyles.randomcolorlist[0]),
      MyTimer(
          ticon: 'swim',
          name: 'swim',
          ison: false,
          tnamelist: [],
          tlengthlist: [],
          colors: ColorStyles.randomcolorlist[1]),
      MyTimer(
          ticon: 'yoga',
          name: 'Yoga',
          ison: false,
          tnamelist: [],
          tlengthlist: [],
          colors: ColorStyles.randomcolorlist[2]),
      MyTimer(
        ticon: 'pen',
        name: 'Study',
        ison: false,
        tnamelist: [],
        tlengthlist: [],
        colors: ColorStyles.randomcolorlist[3],
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size appsize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(color: ColorStyles.lightyellow),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.078,
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.068,
                    child: Row(children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.08,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.70,
                            child: Text(
                              "Hi,Younhui",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorStyles.darkGray),
                            ),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.70,
                            child: Text(
                              "Make your own timer!",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorStyles.darkGray),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,
                      ),
                    ]),
                  ), // greetings, pink box
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.135,
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.623,
                    child: timerPage(),
                  ),
                ],
              ),
            ),
            Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.078,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.12,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.12,
                    decoration: BoxDecoration(
                      color: ColorStyles.lighterpink,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.08,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.073,
                            decoration: BoxDecoration(
                              color: Color(0xff322373),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01,
                          ),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ))),
            Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.16,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: appsize.height * 0.11,
                    // color: Colors.lightBlue,
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.11,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 4.0,
                          offset:
                          Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.175,
                    width: appsize.width * 0.84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        newTimer(),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.02,
                        ),
                        horizontalList(),
                      ],
                    ),
                  ),
                ],
              ),)
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: appsize.height * 0.1,
        surfaceTintColor: Colors.white,
        elevation: 0,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.other_houses_rounded, color: ColorStyles.my, size: 30,),
            Icon(Icons.people_alt_rounded, color: ColorStyles.mm, size: 30,),
            Icon(
              Icons.notifications_rounded, color: ColorStyles.mpi, size: 30,),
            Icon(Icons.settings_rounded, color: ColorStyles.mp, size: 30,)
          ],
        ),
      ),
    );
  }

  Widget timerPage() {
    String formattedTime = _formatTime(_counter);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.6982,
          width: MediaQuery
              .of(context)
              .size
              .width,
        ),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.59,
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)
            ),
          ),
        ),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.6982,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                  valueListenable: selectedTimerIndexNotifier,
                  builder: (_, int _selectedIndex, __) {
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.2,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.2,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color(0xffe87993),
                              Color(0xffe891a1),
                              Color(0xffe59b9b),
                              Color(0xffe8b5b5),
                            ],
                          ),
                          border: Border.all(
                              color: ColorStyles.lightyellow,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.035,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          borderRadius: BorderRadius.all(
                            new Radius.circular(100),
                          )),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          if (_isTimerRunning) {
                            _timer.cancel();
                            setState(() {
                              _isTimerRunning = false;
                            });
                          } else {
                            _timer =
                                Timer.periodic(Duration(seconds: 1), (timer) {
                                  setState(() {
                                    _counter++;
                                  });
                                });
                            setState(() {
                              _isTimerRunning = true;
                              _timerLista[int.parse(_selectedIndex.toString())]
                                  .colors
                                  .border;
                            });
                          }
                          Navigator.push(
                              context,
                              PageTransition(type: PageTransitionType.fade, child: SecondRoute(widget: maxT())));
                        },
                        icon: Icon(
                          _isTimerRunning
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 60.0,
                          color: Colors.white,
                        ),
                      ),
                    );
                    //   Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       alignment: Alignment.center,
                    //       width: 200,
                    //       child: Text(
                    //         _timerLista[int.parse(_selectedIndex.toString())]
                    //             .name,
                    //         style: TextStyles.timerNameTextStyle,
                    //       ),
                    //     ),
                    //   ],
                    // );
                  }),
              // play button
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.025,
              ),
              ValueListenableBuilder(
                  valueListenable: selectedTimerIndexNotifier,
                  builder: (_, int _selectedIndex, __) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 200,
                          child: Text(
                            _timerLista[int.parse(_selectedIndex.toString())]
                                .name,
                            style: TextStyles.timerNameTextStyle,
                          ),
                        ),
                      ],
                    );
                  }),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: 25,
              //       child: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(Icons.circle),
              //           padding: EdgeInsets.zero,
              //           constraints: BoxConstraints(),
              //           color: ColorStyles.linebarback),
              //     ),
              //     SizedBox(
              //       width: 300,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           const SizedBox(
              //             width: 100,
              //             child: LinearProgressIndicator(
              //               borderRadius: BorderRadius.all(Radius.circular(20)),
              //               minHeight: 7,
              //               value: 1,
              //               backgroundColor: ColorStyles.linebarback,
              //               color: ColorStyles.timerfront,
              //             ),
              //           ),
              //           SizedBox(
              //             width: 70,
              //             child: LinearProgressIndicator(
              //               borderRadius: BorderRadius.all(Radius.circular(20)),
              //               minHeight: 7,
              //               value: _counter.toDouble() / 100,
              //               backgroundColor: ColorStyles.linebarback,
              //               color: ColorStyles.timerfront,
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 50,
              //             child: LinearProgressIndicator(
              //               borderRadius: BorderRadius.all(Radius.circular(20)),
              //               minHeight: 7,
              //               value: 0,
              //               backgroundColor: ColorStyles.linebarback,
              //               color: ColorStyles.timerfront,
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 60,
              //             child: LinearProgressIndicator(
              //               borderRadius: BorderRadius.all(Radius.circular(20)),
              //               minHeight: 7,
              //               value: 0,
              //               backgroundColor: ColorStyles.linebarback,
              //               color: ColorStyles.timerfront,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(
              //       width: 25,
              //       child: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(Icons.circle),
              //           padding: EdgeInsets.zero,
              //           constraints: BoxConstraints(),
              //           color: ColorStyles.linebarback),
              //     ),
              //   ],
              // ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.6,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.26,
                  ),
                  ValueListenableBuilder(
                      valueListenable: selectedTimerIndexNotifier,
                      builder: (_, int _selectedIndex, __) {
                        return Positioned(
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.07,
                            child: SizedBox(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.05,
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/${_timerLista[int.parse(
                                            _selectedIndex.toString())]
                                            .ticon}.png'))));
                      }),
                  Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.12,
                      child: SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.05,
                          child: Text(
                            formattedTime,
                            style: TextStyles.maintimerStyle,
                          ))),
                  ValueListenableBuilder(
                      valueListenable: selectedTimerIndexNotifier,
                      builder: (_, int _selectedIndex, __) {
                        return Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.6,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.26,
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                  pointers: <GaugePointer>[],
                                  startAngle: 90,
                                  endAngle: 90,
                                  minimum: 0,
                                  maximum: 100,
                                  //여기를 나중에 타이머 길이로 잡아야지
                                  showLabels: false,
                                  showTicks: false,
                                  axisLineStyle: const AxisLineStyle(
                                    thickness: 0.25,
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: ColorStyles.lightergrey,
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                )
                              ]),
                            ),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.6,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.26,
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                  pointers: <GaugePointer>[],
                                  startAngle: 90,
                                  endAngle: 0,
                                  minimum: 0,
                                  maximum: 100,
                                  //여기를 나중에 타이머 길이로 잡아야지
                                  showLabels: false,
                                  showTicks: false,
                                  axisLineStyle: const AxisLineStyle(
                                    thickness: 0.25,
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: ColorStyles.my,
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                )
                              ]),
                            )
                          ],
                        );
                      }),
                  // Positioned(
                  //     bottom: -12.0,
                  //     child: Container(
                  //         alignment: Alignment.bottomCenter,
                  //         child: IconButton(
                  //           splashColor: Colors.transparent,
                  //           highlightColor: Colors.transparent,
                  //           onPressed: () {
                  //             if (_isTimerRunning) {
                  //               _timer.cancel();
                  //               setState(() {
                  //                 _isTimerRunning = false;
                  //               });
                  //             } else {
                  //               _timer =
                  //                   Timer.periodic(Duration(seconds: 1), (timer) {
                  //                 setState(() {
                  //                   _counter++;
                  //                 });
                  //               });
                  //               setState(() {
                  //                 _isTimerRunning = true;
                  //               });
                  //             }
                  //           },
                  //           icon: Icon(
                  //             _isTimerRunning
                  //                 ? Icons.pause_circle_outline
                  //                 : Icons.play_circle_outline,
                  //             size: 75.0,
                  //             color: ColorStyles.timerfront,
                  //           ),
                  //         ))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: MediaQuery
                      .sizeOf(context)
                      .width * 0.04),
                  Text('35 times used', style: TextStyle(
                      color: ColorStyles.greyback3,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
                  Container(width: MediaQuery
                      .sizeOf(context)
                      .width * 0.27),
                  Row(
                    children: [
                      Icon(
                        Icons.ios_share_rounded, color: ColorStyles.greyback3,
                        size: 30,),
                      Container(width: MediaQuery
                          .sizeOf(context)
                          .width * 0.02),
                      Icon(Icons.edit_rounded, color: ColorStyles.greyback3,
                        size: 30,)
                    ],
                  ),
                  Container(width: MediaQuery
                      .sizeOf(context)
                      .width * 0.04)
                ],
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle, color: ColorStyles.my,
                              size: 15,),
                            Container(width: MediaQuery
                                .sizeOf(context)
                                .width * 0.03,),
                            Text(_timerLista[0].tnamelist[0], style: TextStyle(
                                color: ColorStyles.greyback3,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.circle, color: ColorStyles.mm, size: 15),
                            Container(width: MediaQuery
                                .sizeOf(context)
                                .width * 0.03,),
                            Text(_timerLista[0].tnamelist[1], style: TextStyle(
                                color: ColorStyles.greyback3,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))
                          ],
                        ),
                      ],
                    ),
                    Container(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle, color: ColorStyles.mpi,
                                size: 15),
                            Container(width: MediaQuery
                                .sizeOf(context)
                                .width * 0.03,),
                            Text(_timerLista[0].tnamelist[2], style: TextStyle(
                                color: ColorStyles.greyback3,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.circle, color: ColorStyles.mp, size: 15),
                            Container(width: MediaQuery
                                .sizeOf(context)
                                .width * 0.03,),
                            Text(_timerLista[0].tnamelist[3], style: TextStyle(
                                color: ColorStyles.greyback3,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: MediaQuery
                .of(context)
                .size
                .height * 0.08,
            left: MediaQuery
                .of(context)
                .size
                .width * 0.75,
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.12,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.12,
              decoration: BoxDecoration(
                color: ColorStyles.lighterpink,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.more_horiz_rounded,
                size: 35.0,
                color: ColorStyles.darkGray,
              ),
            ))
      ],
    );
  }

  Widget horizontalList() {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.62,
      height: MediaQuery
          .of(context)
          .size
          .width * 0.14,
      child: ValueListenableBuilder(
          valueListenable: timeListNotifier,
          builder: (_, List<MyTimer> _timerList, __) {
            _timerLista = _timerList;
            return ListView(
              scrollDirection: Axis.horizontal,
              children: _timerList
                  .map((_timer) => horizontalListCell(_timer))
                  .toList(),
            );
          }),
    );
  }

  Widget horizontalListCell(MyTimer timer) {
    Color maincolor = timer.colors.main;
    Color bordercolor = timer.colors.main;
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.1,
                ),
                Positioned(
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.14,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.14,
                      child: InkWell(
                        onTap: () {
                          selectedTimerIndexNotifier.value = 100;
                          selectedTimerIndexNotifier.value =
                              timeListNotifier.value.indexOf(timer);
                          _timerLista = timeListNotifier.value;
                          if (bordercolor == timer.colors.main) {
                            bordercolor = timer.colors.border;
                          } else {
                            bordercolor = timer.colors.main;
                          }
                          // if (_timerLista[timeListNotifier.value.indexOf(timer)]
                          //         .bd ==
                          //     EtcStyles().offBoxDecoration) {
                          //   _timerLista[timeListNotifier.value.indexOf(timer)].bd =
                          //       EtcStyles().onBoxDecoration;
                          // } else {
                          //   _timerLista[timeListNotifier.value.indexOf(timer)].bd =
                          //       EtcStyles().offBoxDecoration;
                          // }
                          // print('get ${ColorStyles.randg.main}');
                          // print('randf ${ColorStyles.randf.main}');
                        },
                        child: ValueListenableBuilder(
                          valueListenable: selectedTimerIndexNotifier,
                          builder: (_, int selectedTimerIndex, __) {
                            return Container(
                                alignment: Alignment.center,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.15,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.15,
                                child: Container(
                                    child: getCircularImage(
                                        timer.ticon, maincolor, bordercolor)));
                          },
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .width * 0.14,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.02,),
      ],
    );
  }

  Widget newTimer() {
    return ValueListenableBuilder(
        valueListenable: timeListNotifier,
        builder: (_, timerl, __) {
          return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        timername = '';
                        iconname = '';
                        print(Icon(String2Icon.getIconDataFromString('add'))
                            .runtimeType);
                        print(
                            String2Icon
                                .getIconDataFromString('account-details')
                                .runtimeType);
                        Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.fade, child: SecondRoute(widget: makeNewt())));
                      },
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .width * 0.14,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.14,
                        decoration: BoxDecoration(
                          color: ColorStyles.lightlime,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Container(
                            padding: const EdgeInsets.all(1),
                            child: Icon(
                              Icons.add_rounded,
                              size: 40,
                              color: Colors.white,
                            )),
                      ))
                ],
              ));
        });
  }

  Container getimgicon(String ticon) {
    Container ticons2 = Container(
        margin: EdgeInsets.all(10),
        child: Image(image: AssetImage('assets/icons/${ticon}.png')));
    return ticons2;
  }

  Widget getCircularImage(String ticon, Color main, Color border) {
    return Container(
      decoration: BoxDecoration(
          color: main,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: border, width: 3)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(new Radius.circular(50)),
        ),
        child: ClipOval(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Image(image: AssetImage('assets/icons/${ticon}.png'))),
        ),
      ),
    );
  }

  Widget timerSlots() {
    return LinearProgressIndicator(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      minHeight: 10,
      value: _counter.toDouble() / 100,
      backgroundColor: ColorStyles.linebarback,
      color: ColorStyles.timerfront,
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    String formattedHours = hours < 10 ? '0$hours' : '$hours';
    String formattedMinutes =
    remainingMinutes < 10 ? '0$remainingMinutes' : '$remainingMinutes';
    String formattedSeconds =
    remainingSeconds < 10 ? '0$remainingSeconds' : '$remainingSeconds';
    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  Widget maxT(){
    String formattedTime = _formatTime(_counter);
    return SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.6982,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                      valueListenable: selectedTimerIndexNotifier,
                      builder: (_, int _selectedIndex, __) {
                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Text(
                                _timerLista[int.parse(
                                    _selectedIndex.toString())]
                                    .name,
                                style: TextStyles.maxmaintimerStyle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Text(
                                _timerLista[int.parse(
                                    _selectedIndex.toString())]
                                    .name,
                                style: TextStyles.maxundertimerStyle,
                              ),
                            )
                          ],
                        );
                      }),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //       width: 25,
                  //       child: IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(Icons.circle),
                  //           padding: EdgeInsets.zero,
                  //           constraints: BoxConstraints(),
                  //           color: ColorStyles.linebarback),
                  //     ),
                  //     SizedBox(
                  //       width: 300,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           const SizedBox(
                  //             width: 100,
                  //             child: LinearProgressIndicator(
                  //               borderRadius: BorderRadius.all(Radius.circular(20)),
                  //               minHeight: 7,
                  //               value: 1,
                  //               backgroundColor: ColorStyles.linebarback,
                  //               color: ColorStyles.timerfront,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 70,
                  //             child: LinearProgressIndicator(
                  //               borderRadius: BorderRadius.all(Radius.circular(20)),
                  //               minHeight: 7,
                  //               value: _counter.toDouble() / 100,
                  //               backgroundColor: ColorStyles.linebarback,
                  //               color: ColorStyles.timerfront,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 50,
                  //             child: LinearProgressIndicator(
                  //               borderRadius: BorderRadius.all(Radius.circular(20)),
                  //               minHeight: 7,
                  //               value: 0,
                  //               backgroundColor: ColorStyles.linebarback,
                  //               color: ColorStyles.timerfront,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 60,
                  //             child: LinearProgressIndicator(
                  //               borderRadius: BorderRadius.all(Radius.circular(20)),
                  //               minHeight: 7,
                  //               value: 0,
                  //               backgroundColor: ColorStyles.linebarback,
                  //               color: ColorStyles.timerfront,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 25,
                  //       child: IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(Icons.circle),
                  //           padding: EdgeInsets.zero,
                  //           constraints: BoxConstraints(),
                  //           color: ColorStyles.linebarback),
                  //     ),
                  //   ],
                  // ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.6,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.26,
                      ),
                      ValueListenableBuilder(
                          valueListenable: selectedTimerIndexNotifier,
                          builder: (_, int _selectedIndex, __) {
                            return Positioned(
                                top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.07,
                                child: SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.06,
                                    child: Image(
                                        image: AssetImage(
                                            'assets/icons/${_timerLista[int
                                                .parse(
                                                _selectedIndex.toString())]
                                                .ticon}.png'))));
                          }),
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.12,
                          child: SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05,
                              child: Text(
                                formattedTime,
                                style: TextStyles.maintimerStyle,
                              ))),
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.16,
                          child: SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05,
                              child: Text(
                                'left until break',
                                style: TextStyles.leftStyle,
                              ))),
                      ValueListenableBuilder(
                          valueListenable: selectedTimerIndexNotifier,
                          builder: (_, int _selectedIndex, __) {
                            return Stack(
                              children: [
                                SizedBox(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.32,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                      pointers: <GaugePointer>[],
                                      startAngle: 90,
                                      endAngle: 90,
                                      minimum: 0,
                                      maximum: 100,
                                      //여기를 나중에 타이머 길이로 잡아야지
                                      showLabels: false,
                                      showTicks: false,
                                      axisLineStyle: const AxisLineStyle(
                                        thickness: 0.24,
                                        cornerStyle: CornerStyle.bothCurve,
                                        color: ColorStyles.lightergrey,
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                    )
                                  ]),
                                ),
                                SizedBox(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.32,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                      pointers: <GaugePointer>[],
                                      startAngle: 90,
                                      endAngle: 0,
                                      minimum: 0,
                                      maximum: 100,
                                      //여기를 나중에 타이머 길이로 잡아야지
                                      showLabels: false,
                                      showTicks: false,
                                      axisLineStyle: const AxisLineStyle(
                                        thickness: 0.24,
                                        cornerStyle: CornerStyle.bothCurve,
                                        color: ColorStyles.my,
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                    )
                                  ]),
                                )
                              ],
                            );
                          }),
                      // Positioned(
                      //     bottom: -12.0,
                      //     child: Container(
                      //         alignment: Alignment.bottomCenter,
                      //         child: IconButton(
                      //           splashColor: Colors.transparent,
                      //           highlightColor: Colors.transparent,
                      //           onPressed: () {
                      //             if (_isTimerRunning) {
                      //               _timer.cancel();
                      //               setState(() {
                      //                 _isTimerRunning = false;
                      //               });
                      //             } else {
                      //               _timer =
                      //                   Timer.periodic(Duration(seconds: 1), (timer) {
                      //                 setState(() {
                      //                   _counter++;
                      //                 });
                      //               });
                      //               setState(() {
                      //                 _isTimerRunning = true;
                      //               });
                      //             }
                      //           },
                      //           icon: Icon(
                      //             _isTimerRunning
                      //                 ? Icons.pause_circle_outline
                      //                 : Icons.play_circle_outline,
                      //             size: 75.0,
                      //             color: ColorStyles.timerfront,
                      //           ),
                      //         ))),
                    ],
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,
                  ),
                  ValueListenableBuilder(
                      valueListenable: selectedTimerIndexNotifier,
                      builder: (_, int _selectedIndex, __) {
                        return Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xfff6b8b8),
                                  Color(0xffef95a2),
                                  Color(0xfff6b8b8),
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                new Radius.circular(100),
                              )),
                          child: TextButton(
                            onPressed: () {
                              if (_isTimerRunning) {
                                _timer.cancel();
                                setState(() {
                                  _isTimerRunning = false;
                                });
                              } else {
                                _timer =
                                    Timer.periodic(
                                        Duration(seconds: 1), (timer) {
                                      setState(() {
                                        _counter++;
                                      });
                                    });
                                setState(() {
                                  _isTimerRunning = true;
                                  _timerLista[int.parse(
                                      _selectedIndex.toString())]
                                      .colors
                                      .border;
                                });
                              }
                            },
                            child: (Text(_isTimerRunning
                                ? 'P A U S E'
                                : 'G O',style: TextStyle(
                                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold
                            ),)),
                          ),
                        );
                        //   Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       alignment: Alignment.center,
                        //       width: 200,
                        //       child: Text(
                        //         _timerLista[int.parse(_selectedIndex.toString())]
                        //             .name,
                        //         style: TextStyles.timerNameTextStyle,
                        //       ),
                        //     ),
                        //   ],
                        // );
                      }),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle, color: ColorStyles.my,
                                  size: 15,),
                                Container(width: MediaQuery
                                    .sizeOf(context)
                                    .width * 0.03,),
                                Text(_timerLista[0].tnamelist[0],
                                    style: TextStyle(
                                        color: ColorStyles.greyback3,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.circle, color: ColorStyles.mm,
                                    size: 15),
                                Container(width: MediaQuery
                                    .sizeOf(context)
                                    .width * 0.03,),
                                Text(_timerLista[0].tnamelist[1],
                                    style: TextStyle(
                                        color: ColorStyles.greyback3,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ],
                        ),
                        Container(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle, color: ColorStyles.mpi,
                                    size: 15),
                                Container(width: MediaQuery
                                    .sizeOf(context)
                                    .width * 0.03,),
                                Text(_timerLista[0].tnamelist[2],
                                    style: TextStyle(
                                        color: ColorStyles.greyback3,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.circle, color: ColorStyles.mp,
                                    size: 15),
                                Container(width: MediaQuery
                                    .sizeOf(context)
                                    .width * 0.03,),
                                Text(_timerLista[0].tnamelist[3],
                                    style: TextStyle(
                                        color: ColorStyles.greyback3,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.08,
              left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.05,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                  size: 30,),
                onPressed: () {
                  Navigator.pop(context);
                },),
            ),
            Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.078,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.12,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.12,
                    decoration: BoxDecoration(
                      color: ColorStyles.lighterpink,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.08,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.073,
                            decoration: BoxDecoration(
                              color: Color(0xff322373),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01,
                          ),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    )))
          ],
        )
    );
  }

  Widget makeNewt() {
    int timeslotcnt = 5;
    Duration initialtimer = new Duration();
    newtimericonNotifier.value = 'questionb';
    return SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: newtimericonNotifier,
            builder: (_, String iconname, __) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Form(
                          child: Column(
                            children: [
                              Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.08,
                              ),
                              Container(
                                child: Row(children: [
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.05,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                                      size: 30,),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.03,
                                  ),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.70,
                                    child: Text(
                                      "Add Timer",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: ColorStyles.darkGray),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02,
                              ),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.9,
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.7,
                                decoration: BoxDecoration(
                                  color: ColorStyles.lightyellow,
                                  borderRadius:
                                  BorderRadius.all(new Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Container(
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.15,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.15,
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                              ),
                                              child: getimgicon(
                                                  newtimericonNotifier.value)),
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  Container(
                                                    height: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.4,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          new Radius.circular(
                                                              20)),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                        ),
                                                        Container(
                                                          height: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.03,
                                                          child: Icon(
                                                              Icons
                                                                  .maximize_rounded,
                                                              size: 50),
                                                        ),
                                                        Container(
                                                          height: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.05,
                                                          alignment:
                                                          Alignment.center,
                                                          child: Text(
                                                            'Change Icon',
                                                            style: TextStyle(
                                                                fontSize: 15.0),
                                                          ),
                                                        ),
                                                        Wrap(
                                                            alignment:
                                                            WrapAlignment.start,
                                                            children: <Widget>[
                                                              for (int i = 0;
                                                              i <
                                                                  iconlist
                                                                      .length;
                                                              i++)
                                                                Container(
                                                                    height: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.1,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.1,
                                                                    child: InkWell(
                                                                      child: getimgicon(
                                                                          iconlist[
                                                                          i]),
                                                                      onTap: () {
                                                                        newtimericonNotifier
                                                                            .value =
                                                                        iconlist[
                                                                        i];
                                                                        isselected =
                                                                        true;
                                                                        setState(
                                                                                () {});
                                                                      },
                                                                    )),
                                                            ]),
                                                        Container(
                                                          height: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.03,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            );
                                          },
                                        ),
                                        Container(
                                          width: 10,
                                        ),
                                        Container(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.15,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.66,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.7),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        20.0)),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white
                                                          .withOpacity(0.7),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        20.0)),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                                focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                                errorStyle: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 13),
                                                errorMaxLines: 1,
                                                labelText: 'timer name',
                                                labelStyle: TextStyle(
                                                    color: Colors.black26,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            onFieldSubmitted: (value) {
                                              debugPrint(
                                                  'onFieldSubmitted $value ');
                                              timername = value;
                                            },
                                            onChanged: (value) {
                                              setState(() {});
                                              debugPrint('change $value');
                                              timername = value;
                                            },
                                            validator: (value) {
                                              debugPrint('validator $value');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.03,
                                    ),
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.82,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        borderRadius: BorderRadius.all(
                                            new Radius.circular(20)),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.03,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.48,
                                            child: RawScrollbar(
                                              timeToFade:
                                              Duration(milliseconds: 1000),
                                              child: SingleChildScrollView(
                                                child: Stack(
                                                  alignment:
                                                  Alignment.topCenter,
                                                  children: [
                                                    Container(
                                                      alignment: Alignment
                                                          .center,
                                                      height: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.6,
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.72,
                                                    ),
                                                    for (int i = 0; i <
                                                        timeslotcnt; i++)
                                                      Positioned(
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.006 +
                                                            i * MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.09,
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              alignment: Alignment
                                                                  .topLeft,
                                                              children: [
                                                                Container(
                                                                  height: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.07,
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width *
                                                                      0.7,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: ColorStyles
                                                                        .greyback1,
                                                                    border: Border
                                                                        .all(
                                                                        color: ColorStyles
                                                                            .greyback1,
                                                                        width: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .width *
                                                                            0.006,
                                                                        strokeAlign: BorderSide
                                                                            .strokeAlignOutside
                                                                    ),
                                                                    borderRadius: BorderRadius
                                                                        .all(
                                                                        new Radius
                                                                            .circular(
                                                                            50)),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.07,
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width *
                                                                      0.55,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: ColorStyles
                                                                        .randomcolorlist[i]
                                                                        .main,
                                                                    border: Border
                                                                        .all(
                                                                        color: ColorStyles
                                                                            .greyback1,
                                                                        width: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .width *
                                                                            0.006,
                                                                        strokeAlign: BorderSide
                                                                            .strokeAlignOutside
                                                                    ),
                                                                    borderRadius: BorderRadius
                                                                        .only(
                                                                        topLeft: Radius
                                                                            .circular(
                                                                            50),
                                                                        bottomLeft: Radius
                                                                            .circular(
                                                                            50)
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.07,
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width *
                                                                      0.7,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color:
                                                                    Colors
                                                                        .black12
                                                                        .withOpacity(
                                                                        0),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                        new Radius
                                                                            .circular(
                                                                            50)),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Container(
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        width: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .width *
                                                                            0.2,
                                                                        child: Text(
                                                                          '=',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                              30),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                        width: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .width *
                                                                            0.3,
                                                                        child: Text(
                                                                          'timeslot',
                                                                          style: TextStyle(
                                                                            fontSize:
                                                                            20,),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        width: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .width *
                                                                            0.2,
                                                                        child: Text(
                                                                          '    m',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                              20),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              height: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.07,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    for (int j = 0; j <
                                                        timeslotcnt; j++)
                                                      Positioned(
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.066 +
                                                              j * MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.09,
                                                          child: InkWell(
                                                            child: ClipOval(
                                                              child: Container(
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: ColorStyles
                                                                      .greyback2,
                                                                  child: Icon(
                                                                    Icons
                                                                        .add_rounded,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 25,
                                                                  )),
                                                            ),
                                                            onTap: () {
                                                              print("?");
                                                              showModalBottomSheet(
                                                                context: context,
                                                                builder: (
                                                                    context) =>
                                                                    Container(
                                                                      height: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.3,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                            new Radius
                                                                                .circular(
                                                                                20)),
                                                                        border: Border
                                                                            .all(
                                                                          color: Colors
                                                                              .white,
                                                                          width: 1,
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        children: [
                                                                          Container(
                                                                            height: MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .height *
                                                                                0.01,
                                                                          ),
                                                                          Container(
                                                                            height: MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .height *
                                                                                0.03,
                                                                            child: Icon(
                                                                                Icons
                                                                                    .maximize_rounded,
                                                                                size: 50),
                                                                          ),
                                                                          Container(
                                                                            height: MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .height *
                                                                                0.01,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment
                                                                                .spaceEvenly,
                                                                            children: [
                                                                              Container(
                                                                                height: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .height *
                                                                                    0.1,
                                                                                width: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .width *
                                                                                    0.4,
                                                                                decoration: BoxDecoration(
                                                                                    color: ColorStyles
                                                                                        .mb,
                                                                                    borderRadius: BorderRadius
                                                                                        .all(
                                                                                        Radius
                                                                                            .circular(
                                                                                            30))
                                                                                ),
                                                                                child: TextButton(
                                                                                  child: Text(
                                                                                      "Add Sound",
                                                                                      style: TextStyle(
                                                                                          fontSize: 20)),
                                                                                  onPressed: () {},
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                height: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .height *
                                                                                    0.1,
                                                                                width: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .width *
                                                                                    0.4,
                                                                                decoration: BoxDecoration(
                                                                                    color: ColorStyles
                                                                                        .mpi,
                                                                                    borderRadius: BorderRadius
                                                                                        .all(
                                                                                        Radius
                                                                                            .circular(
                                                                                            30))
                                                                                ),
                                                                                child: TextButton(
                                                                                  child: Text(
                                                                                    "Add Rest",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20),),
                                                                                  onPressed: () {},
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Container(
                                                                            height: MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .height *
                                                                                0.03,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                              );
                                                            },
                                                          )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                child: Container(
                                  alignment: Alignment.center,
                                  // color: Colors.indigo,
                                  height: 50,
                                  child: Text("save"),
                                ),
                                onPressed: () {
                                  timeListNotifier.value = List.from(
                                      timeListNotifier.value
                                        ..add(MyTimer(
                                            ticon: iconname,
                                            name: timername,
                                            ison: false,
                                            tnamelist: [],
                                            tlengthlist: [],
                                            colors: ColorStyles.randomcolorlist[
                                            Random().nextInt(8)])));
                                  print(_timerLista);
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                        Container(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.078,
                      left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
                      child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.12,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.12,
                          decoration: BoxDecoration(
                            color: ColorStyles.lighterpink,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.08,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.005,
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.073,
                                  decoration: BoxDecoration(
                                    color: Color(0xff322373),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.01,
                                ),
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.005,
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          )))
                ],
              );
            }));
  }

  Widget backdrop() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
      child: Container(
        height: 30,
        color: Colors.black.withOpacity(0.7),
      ),
    );
  }
}
class SecondRoute extends StatelessWidget {
  Widget widget;

  SecondRoute({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: widget);
  }
}

