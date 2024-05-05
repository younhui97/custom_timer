import 'dart:math';
import 'dart:math' as math;
import 'dart:ui';
import 'package:custom_timer/model/mytimer.dart';
import 'package:custom_timer/ui/view/ValuesNotifier.dart';
import 'package:custom_timer/ui/view/timer_detail_page.dart';
import 'package:custom_timer/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  ValueNotifier<bool> timerstateNotifier = ValueNotifier(false);
  ValueNotifier<int> counterNotifier = ValueNotifier(0);

  late Timer _timer;
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
        timerstate: false,
        counter: 0,
        tnamelist: ['LC', 'part 5', 'part 6', 'part 7', 'check time'],
        tlengthlist: [45 * 60, 15 * 60, 20 * 60, 30 * 60, 10 * 60],
        colors: ColorStyles.randomcolorlist[0],
      ),
      MyTimer(
          ticon: 'swim',
          name: 'Swim',
          timerstate: false,
          counter: 0,
          tnamelist: ['freestyle', 'backstroke', 'butterfly', 'breaststroke'],
          tlengthlist: [10 * 60, 30 * 60, 40 * 60, 50 * 60],
          colors: ColorStyles.randomcolorlist[1]),
      MyTimer(
          ticon: 'yoga',
          name: 'Yoga',
          timerstate: false,
          counter: 0,
          tnamelist: [
            'Lizard pose',
            'Low Lunge',
            'Ragdoll pose',
            'Halfway Lunge'
          ],
          tlengthlist: [50 * 60, 30 * 60, 20 * 60, 10 * 60],
          colors: ColorStyles.randomcolorlist[2]),
      MyTimer(
        ticon: 'pen',
        name: 'Study',
        timerstate: false,
        counter: 0,
        tnamelist: ['Rules', 'Insurance', 'Finance', 'Economics'],
        tlengthlist: [10 * 60, 60 * 60, 10 * 60, 10 * 60],
        colors: ColorStyles.randomcolorlist[3],
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size appsize = MediaQuery.of(context).size;

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
                    height: MediaQuery.of(context).size.height * 0.078,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.068,
                    child: Row(children: [
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorStyles.darkGray),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.70,
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
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ]),
                  ), // greetings, pink box
                  Container(
                    height: MediaQuery.of(context).size.height * 0.135,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.623,
                    child: timerPage(),
                  ),
                ],
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.078,
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
                    ))),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.16,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: appsize.height * 0.11,
                    // color: Colors.lightBlue,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 4.0,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width * 0.175,
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
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        horizontalList(),
                      ],
                    ),
                  ),
                ],
              ),
            )
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
            Icon(
              Icons.other_houses_rounded,
              color: ColorStyles.my,
              size: 30,
            ),
            Icon(
              Icons.people_alt_rounded,
              color: ColorStyles.mm,
              size: 30,
            ),
            Icon(
              Icons.notifications_rounded,
              color: ColorStyles.mpi,
              size: 30,
            ),
            Icon(
              Icons.settings_rounded,
              color: ColorStyles.mp,
              size: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget timerPage() {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    String totallogic(tlengthlist) {
      double total = 0;
      for (var element in tlengthlist) {
        total += element;
      }
      String formattedTotal = formatTime(total.round());
      return formattedTotal;
    }

    double circlelogic(tlengthlist, index) {
      double total = 0;
      double stnum = 0;
      double endnum = 0;
      double stangle = 0;
      double endangle = 0;
      for (var element in tlengthlist) {
        total += element;
      }
      for (int i = 0; i < index; i++) {
        stnum += tlengthlist[i];
      }
      for (int i = 0; i < index + 1; i++) {
        endnum += tlengthlist[i];
        if (index == tlengthlist.length - 1) {
          endnum = 0;
        }
      }
      stangle = (((stnum / total * 360) + 90) % 360);
      endangle = (((endnum / total * 360) + 90) % 360);
      return stangle;
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6982,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.59,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: ValuesNotifier([
              selectedTimerIndexNotifier,
              timerstateNotifier,
              timeListNotifier,
              counterNotifier
            ]),
            builder: (_, __, ___) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.6982,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
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
                              width: MediaQuery.of(context).size.width * 0.035,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          borderRadius: BorderRadius.all(
                            new Radius.circular(100),
                          )),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          routeToPage(
                              context,
                              TimerDetailPage(
                                timer: timeListNotifier.value[int.parse(
                                    selectedTimerIndexNotifier.value
                                        .toString())],
                                timerstateNotifier: timerstateNotifier,
                              ));
                        },
                        icon: Icon(
                          Icons.play_arrow_rounded,
                          size: 60.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // play button
                    Container(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 200,
                          child: Text(
                            timeListNotifier
                                .value[int.parse(selectedTimerIndexNotifier
                                    .value
                                    .toString())]
                                .name,
                            style: TextStyles.timerNameTextStyle,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.26,
                        ),
                        ValueListenableBuilder(
                            valueListenable: selectedTimerIndexNotifier,
                            builder: (_, int _selectedIndex, __) {
                              return Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/icons/${timeListNotifier.value[int.parse(_selectedIndex.toString())].ticon}.png'))));
                            }),
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.12,
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text(
                                  totallogic(timeListNotifier
                                      .value[int.parse(
                                          selectedTimerIndexNotifier.value
                                              .toString())]
                                      .tlengthlist),
                                  style: TextStyles.maintimerStyle,
                                ))),
                        ValueListenableBuilder(
                            valueListenable: selectedTimerIndexNotifier,
                            builder: (_, int _selectedIndex, __) {
                              return Stack(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: MediaQuery.of(context).size.height *
                                        0.26,
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
                                          color: Colors.white,
                                          thicknessUnit: GaugeSizeUnit.factor,
                                        ),
                                      )
                                    ]),
                                  ),
                                  for (int i = 0;
                                      i <
                                          timeListNotifier
                                              .value[int.parse(
                                                  _selectedIndex.toString())]
                                              .tlengthlist
                                              .length;
                                      i++)
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.26,
                                      child: SfRadialGauge(axes: <RadialAxis>[
                                        RadialAxis(
                                          pointers: <GaugePointer>[],
                                          startAngle: circlelogic(
                                              timeListNotifier
                                                  .value[int.parse(
                                                      _selectedIndex
                                                          .toString())]
                                                  .tlengthlist,
                                              i),
                                          endAngle: circlelogic(
                                              timeListNotifier
                                                  .value[int.parse(
                                                      _selectedIndex
                                                          .toString())]
                                                  .tlengthlist,
                                              (i + 1) %
                                                  timeListNotifier
                                                      .value[int.parse(
                                                          _selectedIndex
                                                              .toString())]
                                                      .tlengthlist
                                                      .length),
                                          minimum: 0,
                                          maximum: 100,
                                          //여기를 나중에 타이머 길이로 잡아야지
                                          showLabels: false,
                                          showTicks: false,
                                          axisLineStyle: AxisLineStyle(
                                            thickness: 0.25,
                                            cornerStyle: CornerStyle.bothCurve,
                                            color: ColorStyles
                                                .randomcolorlist[i].main,
                                            thicknessUnit: GaugeSizeUnit.factor,
                                          ),
                                        )
                                      ]),
                                    ),
                                ],
                              );
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.sizeOf(context).width * 0.04),
                        Text('35 times used',
                            style: TextStyle(
                                color: ColorStyles.greyback3,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        Container(
                            width: MediaQuery.sizeOf(context).width * 0.27),
                        Row(
                          children: [
                            Icon(
                              Icons.ios_share_rounded,
                              color: ColorStyles.greyback3,
                              size: 30,
                            ),
                            Container(
                                width: MediaQuery.sizeOf(context).width * 0.02),
                            Icon(
                              Icons.edit_rounded,
                              color: ColorStyles.greyback3,
                              size: 30,
                            )
                          ],
                        ),
                        Container(
                            width: MediaQuery.sizeOf(context).width * 0.04)
                      ],
                    ),
                    Container(height: _height * 0.1, child: detaillist())
                  ],
                ),
              );
            }),
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

  Widget horizontalList() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.62,
      height: MediaQuery.of(context).size.width * 0.14,
      child: ValueListenableBuilder(
          valueListenable: timeListNotifier,
          builder: (_, List<MyTimer> _timerList, __) {
            timeListNotifier.value = _timerList;
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
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Positioned(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.14,
                  width: MediaQuery.of(context).size.width * 0.14,
                  child: InkWell(
                    onTap: () {
                      selectedTimerIndexNotifier.value = 100;
                      selectedTimerIndexNotifier.value =
                          timeListNotifier.value.indexOf(timer);
                      timeListNotifier.value = timeListNotifier.value;
                      if (bordercolor == timer.colors.main) {
                        bordercolor = timer.colors.border;
                      } else {
                        bordercolor = timer.colors.main;
                      }
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
            )
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.14,
          width: MediaQuery.of(context).size.width * 0.02,
        ),
      ],
    );
  }

  Widget newTimer() {
    return ValueListenableBuilder(
        valueListenable: timeListNotifier,
        builder: (_, timerl, __) {
          return Container(
              alignment: Alignment.topCenter,
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
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: SecondRoute(widget: makeNewt())));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.14,
                        width: MediaQuery.of(context).size.width * 0.14,
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


  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  Widget maxT() {
    String formattedtime = formatTime(timeListNotifier
        .value[int.parse(selectedTimerIndexNotifier.value.toString())].counter);
    return SingleChildScrollView(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: ValueListenableBuilder(
              valueListenable: ValuesNotifier([
                selectedTimerIndexNotifier,
                timerstateNotifier,
                counterNotifier
              ]),
              builder: (_, __, ___) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: 200,
                      child: Text(
                        timeListNotifier
                            .value[int.parse(
                                selectedTimerIndexNotifier.value.toString())]
                            .name,
                        style: TextStyles.maxmaintimerStyle,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: 200,
                          child: Text(
                            timeListNotifier
                                .value[int.parse(selectedTimerIndexNotifier
                                    .value
                                    .toString())]
                                .name,
                            style: TextStyles.maxundertimerStyle,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.26,
                        ),
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.07,
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/${timeListNotifier.value[int.parse(selectedTimerIndexNotifier.value.toString())].ticon}.png')))),
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.12,
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text(
                                  formatTime(counterNotifier.value),
                                  style: TextStyles.maintimerStyle,
                                ))),
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.16,
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text(
                                  'left until break',
                                  style: TextStyles.leftStyle,
                                ))),
                        Stack(
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
                                    thickness: 0.24,
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
                                    thickness: 0.24,
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: ColorStyles.my,
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                        timerstateNotifier.value
                            ? Container()
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            new Radius.circular(500)),
                                        border: Border.all(
                                            color: ColorStyles.greyback2,
                                            width: 4,
                                            strokeAlign:
                                                BorderSide.strokeAlignInside)),
                                    child: ClipOval(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 7.0, sigmaY: 7.0),
                                        child: Container(
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.26,
                                    height: MediaQuery.of(context).size.height *
                                        0.26,
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.045,
                                          child: Text("Get Some Rest!",
                                              style:
                                                  TextStyles.timerpauseStyle),
                                        ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.045,
                                          child: Text("Starting in",
                                              style:
                                                  TextStyles.timerpauseStyle),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text("25",
                                                style: TextStyles
                                                    .timerpauseStyle2),
                                            Text(" seconds",
                                                style:
                                                    TextStyles.timerpauseStyle)
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ValueListenableBuilder(
                        valueListenable: ValuesNotifier(
                            [selectedTimerIndexNotifier, timerstateNotifier]),
                        builder: (_, __, ___) {
                          return Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.15,
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
                                if (timerstateNotifier.value) {
                                  _timer.cancel();
                                  timerstateNotifier.value = false;
                                } else {
                                  _timer = Timer.periodic(Duration(seconds: 1),
                                      (timer) {
                                    setState(() {
                                      counterNotifier.value = timeListNotifier
                                          .value[int.parse(
                                              selectedTimerIndexNotifier.value
                                                  .toString())]
                                          .counter;
                                      counterNotifier.value++;
                                      timeListNotifier
                                          .value[int.parse(
                                              selectedTimerIndexNotifier.value
                                                  .toString())]
                                          .counter = counterNotifier.value;
                                    });
                                  });
                                  timerstateNotifier.value = true;
                                  timeListNotifier
                                      .value[int.parse(
                                          selectedTimerIndexNotifier.value
                                              .toString())]
                                      .colors
                                      .border;
                                }
                              },
                              child: (Text(
                                timerstateNotifier.value ? 'P A U S E' : 'G O',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Icon(
                            Icons.keyboard_return_rounded,
                            color: ColorStyles.greyback3,
                          ),
                        ),
                        Text(" press long to stop!",
                            style: TextStyle(
                                color: ColorStyles.greyback3,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Now doing ...",
                                  style: TextStyle(
                                      color: ColorStyles.greyback4,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: ColorStyles.greyback1,
                                      border: Border.all(
                                          color: ColorStyles.greyback1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.006,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside),
                                      borderRadius: BorderRadius.all(
                                          new Radius.circular(50)),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    decoration: BoxDecoration(
                                      color: ColorStyles.mb,
                                      border: Border.all(
                                          color: ColorStyles.greyback1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.006,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          bottomLeft: Radius.circular(50)),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.black12.withOpacity(0),
                                      borderRadius: BorderRadius.all(
                                          new Radius.circular(50)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          child: Text(
                                            ' ',
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text(
                                            'timeslot',
                                            style: TextStyle(
                                                color: ColorStyles.greyback4,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Text(
                                            '    m',
                                            style: TextStyle(
                                                color: ColorStyles.greyback4,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text("Coming next ...",
                                  style: TextStyle(
                                      color: ColorStyles.greyback4,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: ColorStyles.greyback1,
                                      border: Border.all(
                                          color: ColorStyles.greyback1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.006,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside),
                                      borderRadius: BorderRadius.all(
                                          new Radius.circular(50)),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    decoration: BoxDecoration(
                                      color: ColorStyles.mb,
                                      border: Border.all(
                                          color: ColorStyles.greyback1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.006,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          bottomLeft: Radius.circular(50)),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.black12.withOpacity(0),
                                      borderRadius: BorderRadius.all(
                                          new Radius.circular(50)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          child: Text(
                                            ' ',
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text(
                                            'timeslot',
                                            style: TextStyle(
                                                color: ColorStyles.greyback4,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Text(
                                            '    m',
                                            style: TextStyle(
                                                color: ColorStyles.greyback4,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.08,
          left: MediaQuery.of(context).size.width * 0.05,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.078,
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
    ));
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
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Container(
                                child: Row(children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              width: MediaQuery.of(context)
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
                                              builder: (context) => Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4,
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.03,
                                                      child: Icon(
                                                          Icons
                                                              .maximize_rounded,
                                                          size: 50),
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
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
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.1,
                                                                width: MediaQuery.of(
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.03,
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          width: MediaQuery.of(context)
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.48,
                                            child: RawScrollbar(
                                              timeToFade:
                                                  Duration(milliseconds: 1000),
                                              child: SingleChildScrollView(
                                                child: Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.6,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.72,
                                                    ),
                                                    for (int i = 0;
                                                        i < timeslotcnt;
                                                        i++)
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.006 +
                                                            i *
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.09,
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              children: [
                                                                Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.07,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.7,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: ColorStyles
                                                                        .greyback1,
                                                                    border: Border.all(
                                                                        color: ColorStyles
                                                                            .greyback1,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.006,
                                                                        strokeAlign:
                                                                            BorderSide.strokeAlignOutside),
                                                                    borderRadius:
                                                                        BorderRadius.all(new Radius
                                                                            .circular(
                                                                            50)),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.07,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.55,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: ColorStyles
                                                                        .randomcolorlist[
                                                                            i]
                                                                        .main,
                                                                    border: Border.all(
                                                                        color: ColorStyles
                                                                            .greyback1,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.006,
                                                                        strokeAlign:
                                                                            BorderSide.strokeAlignOutside),
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                50),
                                                                        bottomLeft:
                                                                            Radius.circular(50)),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.07,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.7,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .black12
                                                                        .withOpacity(
                                                                            0),
                                                                    borderRadius:
                                                                        BorderRadius.all(new Radius
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
                                                                            Alignment.center,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.2,
                                                                        child:
                                                                            Text(
                                                                          '=',
                                                                          style:
                                                                              TextStyle(fontSize: 30),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.3,
                                                                        child:
                                                                            Text(
                                                                          'timeslot',
                                                                          style: TextStyle(
                                                                              color: ColorStyles.greyback4,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.2,
                                                                        child:
                                                                            Text(
                                                                          '    m',
                                                                          style: TextStyle(
                                                                              color: ColorStyles.greyback4,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.07,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    for (int j = 0;
                                                        j < timeslotcnt;
                                                        j++)
                                                      Positioned(
                                                          top: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.066 +
                                                              j *
                                                                  MediaQuery.of(
                                                                          context)
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
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.5,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(new Radius
                                                                            .circular(
                                                                            20)),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 1,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.01,
                                                                      ),
                                                                      Container(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.03,
                                                                        child: Icon(
                                                                            Icons
                                                                                .maximize_rounded,
                                                                            size:
                                                                                50),
                                                                      ),
                                                                      Container(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.01,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.08,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.4,
                                                                            decoration:
                                                                                BoxDecoration(color: ColorStyles.mb, borderRadius: BorderRadius.all(Radius.circular(30))),
                                                                            child:
                                                                                TextButton(
                                                                              child: Text("Add Sound", style: TextStyle(color: ColorStyles.greyback4, fontSize: 18, fontWeight: FontWeight.w600)),
                                                                              onPressed: () {},
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.08,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.4,
                                                                            decoration:
                                                                                BoxDecoration(color: ColorStyles.mpi, borderRadius: BorderRadius.all(Radius.circular(30))),
                                                                            child:
                                                                                TextButton(
                                                                              child: Text(
                                                                                "Add Rest",
                                                                                style: TextStyle(color: ColorStyles.greyback4, fontSize: 18, fontWeight: FontWeight.w600),
                                                                              ),
                                                                              onPressed: () {},
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        height: MediaQuery.of(context).size.height *
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
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
                                            timerstate: false,
                                            counter: 0,
                                            tnamelist: [],
                                            tlengthlist: [],
                                            colors: ColorStyles.randomcolorlist[
                                                Random().nextInt(8)])));
                                  print(timeListNotifier.value);
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
                      top: MediaQuery.of(context).size.height * 0.078,
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

  Widget detaillist() {
    int llength = timeListNotifier
        .value[selectedTimerIndexNotifier.value].tnamelist.length;
    int col = (llength / 2).ceilToDouble().toInt();
    if ((llength / 2) < col) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < col - 1; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: ColorStyles.randomcolorlist[2*i].main,
                      size: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                        timeListNotifier.value[selectedTimerIndexNotifier.value]
                            .tnamelist[2*i],
                        style: TextStyle(
                            color: ColorStyles.greyback3,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: ColorStyles.randomcolorlist[2*i + 1].main,
                      size: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                        timeListNotifier.value[selectedTimerIndexNotifier.value]
                            .tnamelist[2*i + 1],
                        style: TextStyle(
                            color: ColorStyles.greyback3,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                )
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: ColorStyles.randomcolorlist[llength - 1].main,
                    size: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Text(
                      timeListNotifier.value[selectedTimerIndexNotifier.value]
                          .tnamelist[llength - 1],
                      style: TextStyle(
                          color: ColorStyles.greyback3,
                          fontSize: 16,
                          fontWeight: FontWeight.w600))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.white.withOpacity(0.0),
                    size: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Text(
                      timeListNotifier.value[selectedTimerIndexNotifier.value]
                          .tnamelist[llength - 1],
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.0),
                          fontSize: 16,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ],
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < col; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: ColorStyles.randomcolorlist[2*i].main,
                      size: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                        timeListNotifier.value[selectedTimerIndexNotifier.value]
                            .tnamelist[2*i],
                        style: TextStyle(
                            color: ColorStyles.greyback3,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: ColorStyles.randomcolorlist[2*i+1].main,
                      size: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                        timeListNotifier.value[selectedTimerIndexNotifier.value]
                            .tnamelist[2*i + 1],
                        style: TextStyle(
                            color: ColorStyles.greyback3,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                )
              ],
            )
        ],
      );
    }
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
