import 'package:tracker/domain/timer.dart';

/// Business logic work with timers.
class TimerBloc {
  final _firstTimer = TimerModel();
  final _secondTimer = TimerModel();

  TimerModel _currentTimer;

  TimerModel get current => _currentTimer ?? _firstTimer;

  void startFirst() {
    _processActivate(_firstTimer, _secondTimer);
  }

  void startSecond() {
    _processActivate(_secondTimer, _firstTimer);
  }

  void stopFirst() {
    _firstTimer.stop();
  }

  void stopSecond() {
    _secondTimer.stop();
  }

  void _processActivate(TimerModel active, TimerModel another) {
    if (_currentTimer == active) {
      active.resume();
    } else {
      another.stop();
      active.start();
    }

    _currentTimer = active;
  }
}