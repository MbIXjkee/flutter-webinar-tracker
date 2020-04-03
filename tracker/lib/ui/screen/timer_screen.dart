import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracker/logic/timer_bloc.dart';
import 'package:tracker/ui/res/assets.dart';
import 'package:tracker/ui/res/colors.dart';
import 'package:tracker/ui/widget/timer_button.dart';
import 'package:tracker/ui/widget/timer_widget.dart';

/// Screen with timers
class TimerScreen extends StatefulWidget {
  final TimerBloc timerBloc;

  const TimerScreen({Key key, this.timerBloc}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  ActiveButtonState _prevButtonState = ActiveButtonState.none;
  ActiveButtonState _buttonState = ActiveButtonState.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Stack(
      children: <Widget>[
        buildShadow(),
        buildContent(),
      ],
    );
  }

  Widget buildShadow() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
      child: Container(
          width: double.infinity,
          child: FittedBox(
              fit: BoxFit.fitWidth, child: SvgPicture.asset(shadowSvg))),
    );
  }

  Widget buildContent() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 280,
            width: double.infinity,
            color: headColor,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: buildTimer(),
              ),
            ),
          ),
          flex: 45,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TimerButton(),
                        TimerButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          flex: 55,
        )
      ],
    );
  }

  Widget buildTimer() {
    return TimerWidget();
  }
}

/// ActiveButtonState
enum ActiveButtonState { none, first, second }
