import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tracker/domain/timer.dart';
import 'package:tracker/ui/res/colors.dart';

/// Widget for display timer.
class TimerWidget extends StatefulWidget {
  final TimerDataProvider timerData;

  const TimerWidget({
    Key key,
    @required this.timerData,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final _format = NumberFormat('00');

  @override
  Widget build(BuildContext context) {
    var data = widget.timerData;
    var h = data?.hours ?? 0;
    var m = data?.minutes ?? 0;
    var s = data?.seconds ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildBlock(h),
        buildDivider(),
        _buildBlock(m),
        buildDivider(),
        _buildBlock(s),
      ],
    );
  }

  Widget _buildBlock(int value) {

    return Text(
      _format.format(value),
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: timerTextColor,
        fontSize: 48,
        fontWeight: value > 0 ? FontWeight.w300 : FontWeight.w200,
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: 1,
        height: 10,
        color: timerDividerColor,
      ),
    );
}
}
