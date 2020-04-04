import 'dart:async';

/// Model for counting time.
class TimerModel implements TimerDataProvider {
  Timer _ticker;
  var _currentTimeSeconds = 0;

  var _controller = StreamController<TimerDataProvider>.broadcast();

  Stream<TimerDataProvider> get onUpdateStream => _controller.stream;

  @override
  int get hours => _currentTimeSeconds ~/ 3600;

  @override
  int get minutes => (_currentTimeSeconds % 3600) ~/ 60;

  @override
  int get seconds => (_currentTimeSeconds % 3600) % 60;


  TimerModel() {
    _controller.add(this);
  }

  void start() {
    _updateValue(0);
    _startListen();
  }

  void resume() {
    _startListen();
  }

  void stop() {
    _ticker?.cancel();
    _ticker = null;
  }

  void dispose() {
    _controller.close();
  }

  void _startListen() {
    if (_ticker == null) {
      _ticker = Timer.periodic(Duration(seconds: 1), _onTick);
    }
  }

  void _onTick(Timer timer) {
    _updateValue(_currentTimeSeconds + 1);
  }

  void _updateValue(int val) {
    _currentTimeSeconds = val;

    _controller.sink.add(this);
  }
}

/// Interface for provide timer's data
abstract class TimerDataProvider {
  int get hours;

  int get minutes;

  int get seconds;
}
