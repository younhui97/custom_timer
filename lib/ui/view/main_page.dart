import 'package:custom_timer/model/mytimer.dart';
import 'package:custom_timer/ui/etcstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
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
          name: 'Workout-abs',
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
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 40,
          ),
          Row(children: [
            Container(width: 20),
            Flexible(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    'assets/icons/logo.svg',
                    height: 50,
                    width: 100,
                  )),
            ),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.notifications, size: 40.0)),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.settings, size: 40.0)),
          ]),
          const Divider(
            height: 20, // Adjust the height of the line as needed
            color: Colors.black26, // Set the color of the line
            thickness: 1, // Set the thickness of the line
          ),
          // const HorizontalList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 5,
              ),
              newTimer(),
              horizontalList(),
            ],
          ),
          const Divider(
            height: 10, // Adjust the height of the line as needed
            color: Colors.black26, // Set the color of the line
            thickness: 1, // Set the thickness of the line
          ),
          timerPage(),
        ],
      ),
    ));
  }

  Widget timerPage() {
    String formattedTime = _formatTime(_counter);
    return Column(
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
                      _timerLista[int.parse(_selectedIndex.toString())].name,
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
                            _timerLista[int.parse(_selectedIndex.toString())]
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
      ],
    );
  }

  Widget horizontalList() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 85,
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
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
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
                      // print('print ${timeListNotifier.value.indexOf(timer)}');
                    },
                    child: ValueListenableBuilder(
                      valueListenable: selectedTimerIndexNotifier,
                      builder: (_, int selectedTimerIndex, __) {
                        return ClipOval(
                            child: Container(
                                color: ColorStyles.darkGray,
                                child: getCircularImage(timer.ticon, timer.bd))
                            // Text(timer.name, style: TextStyle(color: amI ? Colors.black : Colors.black45, fontWeight:  amI ? FontWeight.bold : FontWeight.normal),),
                            );
                      },
                    ),
                  ),
                ),
                _isTimerRunning
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                            _isTimerRunning
                                ? Icons.pause_circle
                                : Icons.play_circle,
                            size: 20.0),
                        color: ColorStyles.timerback,
                      )
                    : Container()
              ],
            )),
        Text(
          timer.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget newTimer() {
    return ValueListenableBuilder(
        valueListenable: timeListNotifier,
        builder: (_, timerl, __) {
          return SizedBox(
              height: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
                    child: InkWell(
                      onTap: () {
                        timername = '';
                        iconname = '';
                        print(Icon(String2Icon.getIconDataFromString('add'))
                            .runtimeType);
                        print(
                            String2Icon.getIconDataFromString('account-details')
                                .runtimeType);
                        // makeNewt();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SecondRoute(widget: makeNewt())));
                      },
                      child: ClipOval(
                        child: Container(
                            height: 70,
                            width: 70,
                            padding: const EdgeInsets.all(20),
                            color: ColorStyles.circle,
                            child: getIconw('plus')),
                        // child: getSVGImage('assets/icons/plus.svg')),
                      ),
                    ),
                  ),
                  const Text(
                    'New',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
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
          border: const GradientBoxBorder(
            gradient: LinearGradient(colors: [Colors.white, Colors.white]),
            width: 2,
          ),
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
    Duration initialtimer = new Duration();
    newtimericonNotifier.value = 'timer-outline';
    return ValueListenableBuilder(
        valueListenable: newtimericonNotifier,
        builder: (_, String iconname, __) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: ColorStyles.addtimerback,
            child: SingleChildScrollView(
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
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.black54,
                                    width: 2.0,
                                  ),
                                      borderRadius:
                                      BorderRadius.circular(20.0)),
                                  labelText: 'Timer name',
                                ),
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
                                      color: Colors.black54,
                                      width: 2,
                                    ),
                                  ),
                                  child: getIconc(newtimericonNotifier.value)),
                              onTap: () {},
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          width: 370,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(new Radius.circular(20)),
                            border: const GradientBoxBorder(
                              gradient: LinearGradient(
                                  colors: [Colors.black54, Colors.black54]),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 10,
                              ),
                              Container(
                                width: 340,
                                height: 40,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Change Icon',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                              Wrap(
                                  alignment: WrapAlignment.start,
                                  children: <Widget>[
                                    for (int i = 0; i < iconlist.length; i++)
                                      Container(
                                          height: 60,
                                          width: 60,
                                          child: InkWell(
                                            child: getIconc(iconlist[i]),
                                            onTap: () {
                                              newtimericonNotifier.value =
                                                  iconlist[i];
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
                        Container(
                          height: 10,
                        ),
                        Container(
                          width: 370,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(new Radius.circular(20)),
                            border: const GradientBoxBorder(
                              gradient: LinearGradient(
                                  colors: [Colors.black54, Colors.black54]),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 10,
                              ),
                              Container(
                                width: 340,
                                height: 40,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Schedule',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),

                              Container(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 300,
                  //   height: 100,
                  //   child: CupertinoTimerPicker(
                  //     mode: CupertinoTimerPickerMode.hms,
                  //     minuteInterval: 1,
                  //     secondInterval: 1,
                  //     initialTimerDuration: initialtimer,
                  //     onTimerDurationChanged: (Duration changedtimer) {
                  //       setState(() {
                  //         initialtimer = changedtimer;
                  //       });
                  //     },
                  //   )
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: Container(
                            alignment: Alignment.center,
                            // color: Colors.indigo,
                            height: 50,
                            child: Text("cancel"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
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
            ),
          );
        });
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
