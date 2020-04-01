import 'package:tracker/domain/timer.dart';

/// Business logic work with timers.
class TimerBloc {
  final _firstTimer = TimerModel();
  final _secondTimer = TimerModel();

  void startFirst() {
    _secondTimer.stop();
    _firstTimer.start();
  }

  void startSecond() {
    _firstTimer.stop();
    _secondTimer.start();
  }
}