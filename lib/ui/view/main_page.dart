import 'package:custom_timer/model/mytimer.dart';
import 'package:custom_timer/ui/etcstyle.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../colorstyle.dart';
import '../textstyle.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_database/firebase_database.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  ValueNotifier<List<MyTimer>> timeListNotifier = ValueNotifier([]);
  ValueNotifier<int> selectedTimerIndexNotifier = ValueNotifier(0);
  List<MyTimer> _timerLista = [
    MyTimer(imagSrcPath: '', name: 'Name', bd: EtcStyles().offBoxDecoration)
  ];
  int _counter = 0;
  late Timer _timer;
  bool _isTimerRunning = false;

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
          imagSrcPath: 'assets/icons/book.svg',
          name: 'Toeic',
          bd: EtcStyles().offBoxDecoration),
      MyTimer(
          imagSrcPath: 'assets/icons/fitness.svg',
          name: 'Workout-abs',
          bd: EtcStyles().offBoxDecoration),
      MyTimer(
          imagSrcPath: 'assets/icons/yoga.svg',
          name: 'Yoga',
          bd: EtcStyles().offBoxDecoration),
      MyTimer(
          imagSrcPath: 'assets/icons/study.svg',
          name: 'Study',
          bd: EtcStyles().offBoxDecoration),
      MyTimer(
          imagSrcPath: 'assets/icons/cross.svg',
          name: 'Crossfit',
          bd: EtcStyles().offBoxDecoration),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
          IconButton(onPressed: () {}, icon: Icon(Icons.settings, size: 40.0)),
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
        const SizedBox(height: 20),
        SizedBox(
            width: 350,
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              minHeight: 10,
              value: _counter.toDouble() / 100,
              backgroundColor: ColorStyles.linebarback,
              color: ColorStyles.timerfront,
            )
            // SfLinearGauge(
            //   showLabels: false,
            //   showTicks: false,
            //   axisTrackStyle: const LinearAxisTrackStyle(
            //       thickness: 10
            //   ),
            //   ranges: const [
            //     LinearGaugeRange(
            //       startWidth: 10,
            //       endWidth: 10,
            //       startValue: 0,
            //       endValue: 50,
            //       color: Colors.green,
            //     ),
            //     LinearGaugeRange(
            //       startWidth: 10,
            //       endWidth: 10,
            //       startValue: 50,
            //       endValue: 100,
            //       color: Colors.red,
            //     ),
            //   ],
            // ),
            ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
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
                      markerHeight: 25,
                      markerWidth: 25,
                      value: _counter.toDouble(),
                      markerType: MarkerType.circle,
                      color: ColorStyles.timerfront,
                      enableDragging: true,
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
            // SizedBox(
            //   width: 200,
            //   height: 200,
            //   child: CircularProgressIndicator(
            //     value: _isTimerRunning ? _counter / 60.0 : 0.0,
            //     strokeWidth: 10.0,
            //     backgroundColor: ColorStyles.timerback,
            //     valueColor:
            //         const AlwaysStoppedAnimation<Color>(ColorStyles.timerfront),
            //   ),
            // ),
            Positioned(
                top: 80,
                child: SizedBox(
                    height: 50,
                    child: Text(
                      formattedTime,
                      style: TextStyles.timerTextStyle,
                    ))),
            Positioned(
                bottom: -15.0,
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
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
                        size: 80.0,
                        color: ColorStyles.timerfront,
                      ),
                    ))),
          ],
        ),
      ],
    );
  }

  Widget horizontalList() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 80,
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
                        readData();
                        timeListNotifier.value = List.from(
                            timeListNotifier.value
                              ..add(MyTimer(
                                  imagSrcPath: 'assets/icons/book.svg',
                                  name: 'Toeic',
                                  bd: EtcStyles().offBoxDecoration)));
                      },
                      child: ClipOval(
                        child: Container(
                            height: 70,
                            width: 70,
                            padding: const EdgeInsets.all(20),
                            color: ColorStyles.circle,
                            child: getSVGImage('assets/icons/plus.svg')),
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
                                child: getCircularImage(
                                    timer.imagSrcPath, timer.bd))
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

  Widget getSVGImage(String assetName) {
    final Widget timerIcons = SvgPicture.asset(assetName,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn));
    return timerIcons;
  }

  Widget getCircularImage(String assetName, BoxDecoration bd) {
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
              child: getSVGImage(assetName)),
        ),
      ),
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
}
