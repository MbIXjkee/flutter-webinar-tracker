import 'dart:async';

/// Model for counting time.
class TimerModel {
  Timer _ticker;
  var _currentTimeSeconds = 0;

  var _controller = StreamController<int>();

  Stream<int> get onUpdateStream => _controller.stream;

  void start() {
    _currentTimeSeconds = 0;
    _ticker = Timer.periodic(Duration(seconds: 1), _onTick);
  }

  void stop() {
    _ticker?.cancel();
    _ticker = null;
  }

  void dispose() {
    _controller.close();
  }

  void _onTick(Timer timer) {
    _currentTimeSeconds++;
    print(_currentTimeSeconds);

    _controller.sink.add(_currentTimeSeconds);
  }
}