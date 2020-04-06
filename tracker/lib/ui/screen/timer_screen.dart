import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/logic/timer_bloc.dart';
import 'package:tracker/ui/res/assets.dart';

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
        _buildShadow(),
        _buildContent(),
      ],
    );
  }

  Widget _buildShadow() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 45,
            child: Container(),
          ),
          Expanded(
            flex: 55,
            child: Container(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    shadow,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 45,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _buildTimer(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 55,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 100,
                    right: 45,
                    left: 45,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimer() {
    return Text("Timer : here");
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
