import 'package:flutter/cupertino.dart';
import 'package:tracker/logic/timer_bloc.dart';

/// Screen with timers
class TimerScreen extends StatefulWidget {
  final TimerBloc timerBloc;

  const TimerScreen({Key key, this.timerBloc}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}