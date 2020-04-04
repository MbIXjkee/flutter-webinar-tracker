import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracker/domain/timer.dart';
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
        child: SvgPicture.asset(
          shadowSvg,
          fit: BoxFit.fill,
        ),
      ),
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
                        TimerButton(
                          isPressed: _buttonState == ActiveButtonState.first,
                          activatedColor: firstButtonEnabledColor,
                          deactivatedColor: firstButtonDisabledColor,
                          onPressed: _firstPressed,
                        ),
                        TimerButton(
                          isPressed: _buttonState == ActiveButtonState.second,
                          activatedColor: secondButtonEnabledColor,
                          deactivatedColor: secondButtonDisabledColor,
                          onPressed: _secondPressed,
                        ),
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
    var timer = widget.timerBloc.current;
    return StreamBuilder(
      key: ObjectKey(timer),
      stream: timer.onUpdateStream,
      builder: (context, AsyncSnapshot<TimerDataProvider> snapshot) =>
          TimerWidget(timerData: snapshot.data),
    );
  }

  void _firstPressed() {
    if (_buttonState == ActiveButtonState.first) {
      widget.timerBloc.stopFirst();
    } else {
      widget.timerBloc.startFirst();
    }

    _updateButtonState(ActiveButtonState.first);
  }

  void _secondPressed() {
    if (_buttonState == ActiveButtonState.second) {
      widget.timerBloc.stopSecond();
    } else {
      widget.timerBloc.startSecond();
    }

    _updateButtonState(ActiveButtonState.second);
  }

  void _updateButtonState(ActiveButtonState state) {
    setState(() {
      _prevButtonState = _buttonState;
      _buttonState = _prevButtonState == state ? ActiveButtonState.none : state;
    });
  }
}

/// ActiveButtonState
enum ActiveButtonState { none, first, second }
