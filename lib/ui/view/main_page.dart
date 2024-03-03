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
        tnamelist: [],
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
    Size appsize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(color: ColorStyles.lightyellow),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Row(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.70,
                          child: Text(
                            "Hi,Younhui",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: ColorStyles.darkGray),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.70,
                          child: Text(
                            "Make your own timer!",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: ColorStyles.darkGray),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ]), // greetings, pink box
                  Container(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: appsize.height * 0.12,
                        // color: Colors.lightBlue,
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.007,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Color(0xfffef8ef),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: appsize.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            newTimer(),
                            horizontalList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  timerPage(),
                ],
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              left: MediaQuery.of(context).size.width * 0.8,
              child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width * 0.12,
                  width: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color: ColorStyles.lighterpink,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.005,
                          width: MediaQuery.of(context).size.width * 0.073,
                          decoration: BoxDecoration(
                            color: Color(0xff322373),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.005,
                          width: MediaQuery.of(context).size.width * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: [],
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
          height: MediaQuery.of(context).size.height * 0.6982,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.6982,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                  valueListenable: selectedTimerIndexNotifier,
                  builder: (_, int _selectedIndex, __) {
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2,
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
                              width: MediaQuery.of(context).size.width * 0.025,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          borderRadius: BorderRadius.all(
                            new Radius.circular(50),
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
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ValueListenableBuilder(
                  valueListenable: selectedTimerIndexNotifier,
                  builder: (_, int _selectedIndex, __) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // IconButton(
                        //     onPressed: () {
                        //       if (0 < selectedTimerIndexNotifier.value) {
                        //         selectedTimerIndexNotifier.value--;
                        //       } else {
                        //         print("no more way to go");
                        //       }
                        //     },
                        //     icon: const Icon(
                        //       Icons.arrow_back_ios,
                        //       color: Colors.white,
                        //     )),
                        Container(
                          alignment: Alignment.center,
                          width: 200,
                          child: Text(
                            _timerLista[int.parse(_selectedIndex.toString())]
                                .name,
                            style: TextStyles.timerNameTextStyle,
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       if (selectedTimerIndexNotifier.value <
                        //           _timerLista.length - 1) {
                        //         selectedTimerIndexNotifier.value++;
                        //       } else {
                        //         print("no more way to go");
                        //       }
                        //     },
                        //     icon: const Icon(Icons.arrow_forward_ios,
                        //         color: Colors.white)),
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  ValueListenableBuilder(
                      valueListenable: selectedTimerIndexNotifier,
                      builder: (_, int _selectedIndex, __) {
                        return Positioned(
                            top: MediaQuery.of(context).size.height * 0.09,
                            child: SizedBox(
                                height: 40,
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/${_timerLista[int.parse(_selectedIndex.toString())].ticon}.png'))));
                      }),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.14,
                      child: SizedBox(
                          height: 50,
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
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.3,
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
                                    thickness: 0.2,
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: ColorStyles.lightergrey,
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                )
                              ]),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.3,
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
                                    thickness: 0.2,
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
              // Icon(String2Icon.getIconDataFromString('account-details'))
              // try2()
            ],
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: MediaQuery.of(context).size.width * 0.75,
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.width * 0.12,
              width: MediaQuery.of(context).size.width * 0.12,
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

  void timerformula(List a) {
    // ValueListenableBuilder(
    //     valueListenable: selectedTimerIndexNotifier,
    //     builder: (_, int _selectedIndex, __) {
    //       return Positioned(
    //           top: MediaQuery.of(context).size.height * 0.09,
    //           child: SizedBox(
    //               height: 40,
    //               child: Image(
    //                   image: AssetImage(
    //                       'assets/icons/${_timerLista[int.parse(_selectedIndex.toString())].ticon}.png'))
    //           ));
    //     }),
  }

  Widget horizontalList() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 100,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
                Positioned(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
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
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Container(
                                child: getCircularImage(
                                    timer.ticon, maincolor, bordercolor)));
                      },
                    ),
                  ),
                )),
              ],
            )),
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
                            String2Icon.getIconDataFromString('account-details')
                                .runtimeType);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SecondRoute(widget: makeNewt())));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            color: ColorStyles.lightlime,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.add_rounded,
                                size: 40,
                                color: Colors.white,
                              )),
                        ),
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
          borderRadius: BorderRadius.circular(50),
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

  Widget makeNewt() {
    int timeslotcnt = 1;
    Duration initialtimer = new Duration();
    newtimericonNotifier.value = 'questionb';
    return SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: newtimericonNotifier,
            builder: (_, String iconname, __) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Form(
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                              ),
                              Container(
                                child: Row(children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
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
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                decoration: BoxDecoration(
                                  color: ColorStyles.lightyellow,
                                  borderRadius:
                                      BorderRadius.all(new Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Container(
                                              height: 65,
                                              width: 65,
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
                                              // backgroundColor: Colors.transparent,
                                              builder: (context) => Container(
                                                height: 350,
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
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      child: Icon(
                                                          Icons
                                                              .maximize_rounded,
                                                          size: 50),
                                                    ),
                                                    Container(
                                                      width: 340,
                                                      height: 30,
                                                      alignment:
                                                          Alignment.centerLeft,
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
                                                                height: 70,
                                                                width: 70,
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
                                                      height: 10,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.66,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                filled: true,
                                                fillColor: Colors.white,
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
                                      height: 10,
                                    ),
                                    Container(
                                      width: 370,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                            height: 10,
                                          ),
                                          Container(
                                            width: 340,
                                            height: 20,
                                            child: Text(
                                              '',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 300,
                                            child: RawScrollbar(
                                              timeToFade:
                                                  Duration(milliseconds: 1000),
                                              child: SingleChildScrollView(
                                                child: Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    Container(
                                                      height: 300,
                                                    ),
                                                    for (int i = 0;
                                                        i < timeslotcnt;
                                                        i++)
                                                      Positioned(
                                                        top: i * 55,
                                                        child: Container(
                                                          height: 50,
                                                          width: 300,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorStyles
                                                                .timerfront,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    new Radius
                                                                        .circular(
                                                                        50)),
                                                            border: Border.all(
                                                              color: ColorStyles
                                                                  .timerfront,
                                                              width: 1,
                                                            ),
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
                                                                width: 40,
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
                                                                        .center,
                                                                width: 200,
                                                                child: Text(
                                                                  'timeslot',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 40,
                                                                child: Text(
                                                                  'm',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    for (int j = 0;
                                                        j < timeslotcnt;
                                                        j++)
                                                      Positioned(
                                                          top: 40 + j * 55,
                                                          child: InkWell(
                                                            child: ClipOval(
                                                              child: Container(
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .white,
                                                                  child: Icon(
                                                                    Icons
                                                                        .add_rounded,
                                                                    size: 25,
                                                                  )),
                                                            ),
                                                            onTap: () {
                                                              print("?");
                                                            },
                                                          )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 10,
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
                      top: MediaQuery.of(context).size.height * 0.08,
                      left: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width * 0.12,
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: BoxDecoration(
                            color: ColorStyles.lighterpink,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                  width:
                                      MediaQuery.of(context).size.width * 0.073,
                                  decoration: BoxDecoration(
                                    color: Color(0xff322373),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
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
