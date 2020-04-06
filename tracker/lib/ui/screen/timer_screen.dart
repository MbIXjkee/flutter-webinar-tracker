import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/logic/timer_bloc.dart';

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
    return Container();
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
