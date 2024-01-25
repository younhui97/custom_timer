import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../colorstyle.dart';
import '../textstyle.dart';
import '../timerStore.dart';
import '../widget/horizontalList.dart';
import 'package:provider/provider.dart';

class TimerDetails extends StatefulWidget {
  const TimerDetails({super.key, superkey});

  @override
  State<TimerDetails> createState() => TimerDetailsm();

}
class TimerDetailsm extends State<TimerDetails> {
  final timestore = TimeStore();
  String timername='';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListenableBuilder(listenable: timestore, builder: (BuildContext context, Widget? child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                Text(timestore.str, style: TextStyles.timerNameTextStyle),
                IconButton(onPressed: (){
                  timername = timestore.str;
                  print(timername);
                  setState(() {});
                }, icon: Icon(Icons.arrow_forward_ios)),
              ],
            );
          }, ),
        ],
      )
    );
  }
}
