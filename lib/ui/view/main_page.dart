import 'dart:ui';

import 'package:custom_timer/model/mytimer.dart';
import 'package:custom_timer/ui/etcstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../colorstyle.dart';
import '../textstyle.dart';
import 'package:flutter_svg/svg.dart';
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
  ValueNotifier<String> newtimericonNotifier = ValueNotifier('timer-outline');
  List<MyTimer> _timerLista = [
    MyTimer(
        ticon: 'remove',
        name: 'Name',
        ison: false,
        bd: EtcStyles().offBoxDecoration,
        tnamelist: [],
        tlengthlist: [])
  ];
  int _counter = 0;
  late Timer _timer;
  bool _isTimerRunning = false;
  String timername = '';
  String iconname = 'remove';
  bool isselected = false;
  List<String> iconlist = [
    'timer-outline',
    'book-open-outline',
    'lead-pencil',
    'briefcase-outline',
    'laptop',
    'dumbbell',
    'yoga',
    'swim',
    'jump-rope',
    'chef-hat',
    'cookie',
    'blender'
  ];

  @override
  void initState() {
    _initRequiredDataList();
    super.initState();
    // Sample to add&update notifier
    // timeListNotifier.value = List.from(timeListNotifier.value..add(MyTimer(imagSrcPath: "imagSrcPath", name: "name", title: "title")));
  }

  void _initRequiredDataList() {
    timeListNotifier.value = List<MyTimer>.from([
      MyTimer(
          ticon: 'book-open-outline',
          name: 'Toeic',
          ison: false,
          bd: EtcStyles().offBoxDecoration,
          tnamelist: [],
          tlengthlist: []),
      MyTimer(
          ticon: 'dumbbell',
          name: 'Workout',
          ison: false,
          bd: EtcStyles().offBoxDecoration,
          tnamelist: [],
          tlengthlist: []),
      MyTimer(
          ticon: 'yoga',
          name: 'Yoga',
          ison: false,
          bd: EtcStyles().offBoxDecoration,
          tnamelist: [],
          tlengthlist: []),
      MyTimer(
          ticon: 'lead-pencil',
          name: 'Study',
          ison: false,
          bd: EtcStyles().offBoxDecoration,
          tnamelist: [],
          tlengthlist: []),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size appsize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(color: ColorStyles.lightyellow),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 45,
              ),
              Row(children: [
                Container(
                  width: 30,
                ),
                Column(
                  children: [
                    Container(
                      width: 300,
                      child: Text(
                        "Hi,Younhui",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorStyles.darkGray),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Make your own timer!",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorStyles.darkGray),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.center,
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: ColorStyles.lighterpink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 3,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xff3A20A4),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Container(
                            height: 5,
                          ),
                          Container(
                            height: 3,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ))
              ]), // greetings, pink box
              Container(
                height: 10,
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: appsize.height * 0.12,
                    // color: Colors.lightBlue,
                  ),
                  Positioned(
                    bottom: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Color(0xfffef8ef),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 10.0,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: appsize.height * 0.11,
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
                height: 10,
              ),
              timerPage(),
            ],
          ),
        ),
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
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 400,
          width: 380,
        ),
        Column(
          children: [
            ValueListenableBuilder(
                valueListenable: selectedTimerIndexNotifier,
                builder: (_, int _selectedIndex, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (0 < selectedTimerIndexNotifier.value) {
                              selectedTimerIndexNotifier.value--;
                            } else {
                              print("no more way to go");
                            }
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                      Container(
                        alignment: Alignment.center,
                        width: 200,
                        child: Text(
                          _timerLista[int.parse(_selectedIndex.toString())]
                              .name,
                          style: TextStyles.timerNameTextStyle,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (selectedTimerIndexNotifier.value <
                                _timerLista.length - 1) {
                              selectedTimerIndexNotifier.value++;
                            } else {
                              print("no more way to go");
                            }
                          },
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ],
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.circle),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      color: ColorStyles.linebarback),
                ),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 100,
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          minHeight: 7,
                          value: 1,
                          backgroundColor: ColorStyles.linebarback,
                          color: ColorStyles.timerfront,
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          minHeight: 7,
                          value: _counter.toDouble() / 100,
                          backgroundColor: ColorStyles.linebarback,
                          color: ColorStyles.timerfront,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          minHeight: 7,
                          value: 0,
                          backgroundColor: ColorStyles.linebarback,
                          color: ColorStyles.timerfront,
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          minHeight: 7,
                          value: 0,
                          backgroundColor: ColorStyles.linebarback,
                          color: ColorStyles.timerfront,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 25,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.circle),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      color: ColorStyles.linebarback),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 230,
                  height: 230,
                  child: SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: _counter.toDouble(),
                          width: 0.1,
                          sizeUnit: GaugeSizeUnit.factor,
                          cornerStyle: CornerStyle.startCurve,
                          color: ColorStyles.timerfront,
                        ),
                        MarkerPointer(
                          markerHeight: 20,
                          markerWidth: 20,
                          value: _counter.toDouble() + 1.85,
                          markerType: MarkerType.circle,
                          color: ColorStyles.timerfront,
                          enableDragging: false,
                          enableAnimation: true,
                        )
                      ],
                      startAngle: 115,
                      endAngle: 65,
                      minimum: 0,
                      maximum: 100,
                      //여기를 나중에 타이머 길이로 잡아야지
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 0.1,
                        cornerStyle: CornerStyle.bothCurve,
                        color: ColorStyles.timerback,
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                    )
                  ]),
                ),
                ValueListenableBuilder(
                    valueListenable: selectedTimerIndexNotifier,
                    builder: (_, int _selectedIndex, __) {
                      return Positioned(
                          top: 65,
                          child: SizedBox(
                              height: 50,
                              child: Text(
                                _timerLista[
                                        int.parse(_selectedIndex.toString())]
                                    .name,
                                style: TextStyles.maintimernameStyle,
                              )));
                    }),
                Positioned(
                    top: 85,
                    child: SizedBox(
                        height: 50,
                        child: Text(
                          formattedTime,
                          style: TextStyles.maintimerStyle,
                        ))),
                Positioned(
                    bottom: -12.0,
                    child: Container(
                        alignment: Alignment.bottomCenter,
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
                              });
                            }
                          },
                          icon: Icon(
                            _isTimerRunning
                                ? Icons.pause_circle_outline
                                : Icons.play_circle_outline,
                            size: 75.0,
                            color: ColorStyles.timerfront,
                          ),
                        ))),
              ],
            ),
            // Icon(String2Icon.getIconDataFromString('account-details'))
            // try2()
          ],
        )
      ],
    );
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
                      if (_timerLista[timeListNotifier.value.indexOf(timer)]
                              .bd ==
                          EtcStyles().offBoxDecoration) {
                        _timerLista[timeListNotifier.value.indexOf(timer)].bd =
                            EtcStyles().onBoxDecoration;
                      } else {
                        _timerLista[timeListNotifier.value.indexOf(timer)].bd =
                            EtcStyles().offBoxDecoration;
                      }
                      print('get ${ColorStyles.randomFromMain.main}');
                      print('randf ${ColorStyles.randf.main}');
                    },
                    child: ValueListenableBuilder(
                      valueListenable: selectedTimerIndexNotifier,
                      builder: (_, int selectedTimerIndex, __) {
                        return Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            // decoration: BoxDecoration(
                            //   color: ColorStyles.darkGray,
                            //   borderRadius: BorderRadius.circular(50),
                            // ),
                            child: Container(
                                child:
                                    getCircularImage(timer.ticon, timer.bd)));
                      },
                    ),
                  ),
                )),
                _isTimerRunning
                    ? Positioned(
                        top: 55,
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorStyles.timeron,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                new Radius.circular(5),
                              )),
                          child: Icon(
                            _isTimerRunning
                                ? Icons.play_arrow_rounded
                                : Icons.play_arrow_rounded,
                            size: 15.0,
                            color: Colors.white,
                          ),
                        ))
                    : Container(),
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
                        print(String2Icon.getIconDataFromString(
                            'account-details')
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
                              child: getIconw('plus')),
                        ),
                      ))
                ],
              ));
        });
  }

  Icon getIconw(String ticon) {
    Icon ticons = Icon(
      String2Icon.getIconDataFromString(ticon),
      color: Colors.white,
      size: 30,
    );
    return ticons;
  }

  Icon getIconc(String ticon) {
    Icon ticons = Icon(
      String2Icon.getIconDataFromString(ticon),
      color: const Color(0xff363636),
      size: 35,
    );
    return ticons;
  }

  Widget getCircularImage(String ticon, BoxDecoration bd) {
    return Container(
      decoration: bd,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(new Radius.circular(50)),
        ),
        child: ClipOval(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Icon(
              String2Icon.getIconDataFromString(ticon),
              color: Colors.white,
              size: 30,
            ),
          ),
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
    String formattedMinutes = minutes < 10 ? '0$minutes' : '$minutes';
    String formattedSeconds =
        remainingSeconds < 10 ? '0$remainingSeconds' : '$remainingSeconds';
    return '$formattedMinutes:$formattedSeconds';
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
    newtimericonNotifier.value = 'timer-outline';
    return ValueListenableBuilder(
        valueListenable: newtimericonNotifier,
        builder: (_, String iconname, __) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: ColorStyles.addtimerback,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  errorStyle: const TextStyle(
                                      color: Colors.red, fontSize: 13),
                                  errorMaxLines: 1,
                                  labelText: 'Timer name',
                                  labelStyle: TextStyle(color: Colors.black26)),
                              onFieldSubmitted: (value) {
                                debugPrint('onFieldSubmitted $value ');
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
                          Container(
                            width: 10,
                          ),
                          InkWell(
                            child: Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: getIconc(newtimericonNotifier.value)),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                // backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                  height: 350,
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
                                        height: 30,
                                        child: Icon(Icons.maximize_rounded,
                                            size: 50),
                                      ),
                                      Container(
                                        width: 340,
                                        height: 30,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Change Icon',
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ),
                                      Wrap(
                                          alignment: WrapAlignment.start,
                                          children: <Widget>[
                                            for (int i = 0;
                                                i < iconlist.length;
                                                i++)
                                              Container(
                                                  height: 70,
                                                  width: 70,
                                                  child: InkWell(
                                                    child:
                                                        getIconc(iconlist[i]),
                                                    onTap: () {
                                                      newtimericonNotifier
                                                          .value = iconlist[i];
                                                      isselected = true;
                                                      setState(() {});
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
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      // Container(
                      //   width: 370,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius:
                      //         BorderRadius.all(new Radius.circular(20)),
                      //     border: Border.all(
                      //       color: Colors.white,
                      //       width: 1,
                      //     ),
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         height: 10,
                      //       ),
                      //       Container(
                      //         width: 340,
                      //         height: 40,
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(
                      //           'Change Icon',
                      //           style: TextStyle(fontSize: 15.0),
                      //         ),
                      //       ),
                      //       Wrap(
                      //           alignment: WrapAlignment.start,
                      //           children: <Widget>[
                      //             for (int i = 0; i < iconlist.length; i++)
                      //               Container(
                      //                   height: 50,
                      //                   width: 60,
                      //                   child: InkWell(
                      //                     child: getIconc(iconlist[i]),
                      //                     onTap: () {
                      //                       newtimericonNotifier.value =
                      //                           iconlist[i];
                      //                       isselected = true;
                      //                       setState(() {});
                      //                     },
                      //                   )),
                      //           ]),
                      //       Container(
                      //         height: 10,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        width: 370,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(new Radius.circular(20)),
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
                                'Schedule',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                            Container(
                              height: 300,
                              child: SingleChildScrollView(
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      height: 500,
                                    ),
                                    for (int i = 0; i < timeslotcnt; i++)
                                      Positioned(
                                        top: i * 55,
                                        child: Container(
                                          height: 50,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            color: ColorStyles.timerfront,
                                            borderRadius: BorderRadius.all(
                                                new Radius.circular(50)),
                                            border: Border.all(
                                              color: ColorStyles.timerfront,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 40,
                                                child: Text(
                                                  '=',
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: 200,
                                                child: Text(
                                                  'timeslot',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: 40,
                                                child: Text(
                                                  'm',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    for (int j = 0; j < timeslotcnt; j++)
                                      Positioned(
                                          top: 40 + j * 55,
                                          child: InkWell(
                                            child: ClipOval(
                                              child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  color: Colors.white,
                                                  child: Icon(
                                                    Icons.add_rounded,
                                                    size: 25,
                                                  )),
                                              // child: getSVGImage('assets/icons/plus.svg')),
                                            ),
                                            onTap: () {
                                              print("?");
                                            },
                                          )),
                                  ],
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
                                    bd: EtcStyles().offBoxDecoration,
                                    tnamelist: [],
                                    tlengthlist: [])));
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
          );
        });
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

  Widget try2() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/b.jpeg'), fit: BoxFit.cover),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  Widget widget;

  SecondRoute({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Add Timer',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: widget);
  }
}
