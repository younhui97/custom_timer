import 'dart:math';
import 'dart:math' as math;
import 'dart:ui';
import 'package:custom_timer/model/mytimer.dart';
import 'package:custom_timer/ui/view/ValuesNotifier.dart';
import 'package:custom_timer/ui/view/new_timer.dart';
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
        // tlengthlist: [45 * 60, 15 * 60, 20 * 60, 30 * 60, 10 * 60],
        tlengthlist: [5,4,3,2,1],
        colors: ColorStyles.randomcolorlist[0],
      ),
      MyTimer(
          ticon: 'swim',
          name: 'Swim',
          timerstate: false,
          counter: 0,
          tnamelist: ['freestyle', 'backstroke', 'butterfly', 'breaststroke'],
          tlengthlist: [1,3,4,5],
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
          tlengthlist: [3,4,5,1],
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
                    Container(height: _height * 0.1, child: detaillist(context,timeListNotifier.value[selectedTimerIndexNotifier.value]))
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
                        routeToPage(
                            context,
                            NewTimer(
                              timer: timeListNotifier.value[int.parse(
                                  selectedTimerIndexNotifier.value
                                      .toString())],
                              timeListNotifier: timeListNotifier,
                            ));
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

}

