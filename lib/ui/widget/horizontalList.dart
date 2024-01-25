import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../colorstyle.dart';
import '../textstyle.dart';
import '../etcstyle.dart';
import 'package:provider/provider.dart';

import '../timerStore.dart';

class HorizontalList extends StatefulWidget {
  const HorizontalList({Key? key}) : super(key: key);
  @override
  State<HorizontalList> createState() => TimerList();

}

class TimerList extends State<HorizontalList> {
  final timestore = TimeStore();
  BoxDecoration currentBoxDecoration = EtcStyles().offBoxDecoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // Adjust the height as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListenableBuilder(
                    listenable: timestore,
                    builder: (BuildContext context, Widget? child) {
                      return SizedBox(
                        height: 50,
                        width: 50,
                        child: InkWell(
                          onTap: () {
                            print("new timer ");
                            timestore.imagePaths.add('assets/icons/cross.svg');
                            timestore.timerNames.add('Crossfit');
                            timestore.timerStates
                                .add(EtcStyles().offBoxDecoration);
                            print(timestore.timerNames);
                            setState(() {});
                          },
                          child: ClipOval(
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                width: 100.0,
                                height: 100.0,
                                color: ColorStyles.circle,
                                child: getSVGImage('assets/icons/plus.svg')),
                          ),
                        ),
                      );
                    }),
                Text('New', style: TextStyles.timerTextStyle),
              ],
            ),
          ),
          Flexible(
            child: ListenableBuilder(
              listenable: timestore, builder: (BuildContext context, Widget? child) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: timestore.timerNames.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: InkWell(
                            onTap: () {
                              timestore.str = timestore.timerNames[index];
                              print(timestore.str);
                              setState(() {});
                            },
                            child: ClipOval(
                              child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  color: ColorStyles.darkGray,
                                  child: getCircularImage(
                                      timestore.imagePaths[index], index)),
                            ),
                          ),
                        ),
                        Text(timestore.timerNames[index],
                            style: TextStyles.timerTextStyle),
                      ],
                    )
                  );
                },
              );
            },

            )
          )
        ],
      ),
    );
  }

  Widget getSVGImage(String assetName) {
    final Widget timerIcons = SvgPicture.asset(assetName,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn));
    return timerIcons;
  }

  Widget getCircularImage(String assetName, int index) {
    return ListenableBuilder(
        listenable: timestore,
        builder: (BuildContext context, Widget? child) {
          return Container(
            width: 50,
            height: 50,
            decoration: timestore.timerStates[index],
            child: Container(width: 50, height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(new Radius.circular(50)),
                border: const GradientBoxBorder(
                  gradient:
                      LinearGradient(colors: [Colors.white, Colors.white]),
                  width: 1,
                ),
              ),
              child: ClipOval(
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    width: 100.0,
                    height: 100.0,
                    child: getSVGImage(assetName)),
              ),
            ),
          );
        });
  }
}
