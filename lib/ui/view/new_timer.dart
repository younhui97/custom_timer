import 'dart:math';

import 'package:custom_timer/model/mytimer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colorstyle.dart';

class NewTimer extends StatefulWidget {
  final MyTimer timer;
  final ValueNotifier<List<MyTimer>> timeListNotifier;
  NewTimer({required this.timer, required this.timeListNotifier});
  @override
  State<NewTimer> createState() => _NewTimerState();
}

class _NewTimerState extends State<NewTimer> {
  ValueNotifier<String> newtimericonNotifier = ValueNotifier('questionb');
  List<String> iconlist = ['bicycle', 'book', 'cook', 'swim', 'yoga'];
  bool isselected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: makeNewt(),
    );
  }

  Container getimgicon(String ticon) {
    Container ticons2 = Container(
        margin: EdgeInsets.all(10),
        child: Image(image: AssetImage('assets/icons/${ticon}.png')));
    return ticons2;
  }

  Widget makeNewt() {
    String timername = '';
    int timeslotcnt = 5;
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
                                  widget.timeListNotifier.value = List.from(
                                      widget.timeListNotifier.value
                                        ..add(MyTimer(
                                            ticon: iconname,
                                            name: timername,
                                            timerstate: false,
                                            counter: 0,
                                            tnamelist: [],
                                            tlengthlist: [],
                                            colors: ColorStyles.randomcolorlist[
                                            Random().nextInt(8)])));
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
}
