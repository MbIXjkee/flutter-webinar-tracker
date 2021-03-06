import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/ui/res/colors.dart';

/// Button for manage timer
class TimerButton extends StatefulWidget {
  final bool isPressed;
  final Color deactivatedColor;
  final Color activatedColor;
  final VoidCallback onPressed;

  const TimerButton({
    Key key,
    @required this.deactivatedColor,
    @required this.activatedColor,
    @required this.onPressed,
    this.isPressed = false,
  }) : super(key: key);

  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton>
    with SingleTickerProviderStateMixin {
  static const double _buttonSize = 90;
  static const double _buttonOuterShadowSize = 5;
  static const double _indicatorSize = 12;
  static const double _indicatorBlurRadius = 4;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void didUpdateWidget(TimerButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isPressed && _controller.value != 1) {
      _controller.forward();
    } else if (!widget.isPressed && _controller.value != 0) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: _buildButtonBody(),
    );
  }

  Widget _buildButtonBody() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Stack(
        children: <Widget>[
          _buildOuterShadow(),
          Center(
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_buttonSize / 2),
                  color: backgroundColor,
                ),
                height: _buttonSize,
                width: _buttonSize,
                child: Center(child: _buildIndicator()),
              ),
            ),
          ),
          _buildInnerShadow(),
        ],
      ),
    );
  }

  Widget _buildOuterShadow() {
    return Center(
      child: Opacity(
        opacity: 1 - (_controller.value / 0.75).clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  _buttonSize / 2 + _buttonOuterShadowSize),
              boxShadow: [
                BoxShadow(
                  color: shadowMainColor,
                  spreadRadius: _buttonOuterShadowSize,
                  blurRadius: _buttonOuterShadowSize,
                ),
                BoxShadow(
                    color: shadowTintColor,
                    spreadRadius: 0,
                    blurRadius: _buttonOuterShadowSize,
                    offset: Offset(0, -_buttonOuterShadowSize))
              ]),
          width: _buttonSize,
          height: _buttonSize,
        ),
      ),
    );
  }

  Widget _buildInnerShadow() {
    return IgnorePointer(
      child: Opacity(
        opacity: ((_controller.value - 0.55) / 0.45).clamp(0.0, 1.0),
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: shadowMainColor,
                  gradient: RadialGradient(
                    colors: [
                      shadowMainColor.withOpacity(0.0),
                      shadowMainColor.withOpacity(0.5),
                    ],
                    center: AlignmentDirectional(0.0, 0.5),
                    focal: AlignmentDirectional(0.0, 0.1),
                    focalRadius: 0.005,
                    radius: 0.95,
                    stops: [0.5, 1],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: shadowMainColor,
                  gradient: RadialGradient(
                    colors: [
                      shadowTintColor.withOpacity(0.0),
                      shadowTintColor.withOpacity(0.5),
                    ],
                    center: AlignmentDirectional(0.0, -0.5),
                    focal: AlignmentDirectional(0.0, 0.1),
                    focalRadius: 0.005,
                    radius: 0.95,
                    stops: [0.5, 1.0],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Stack(
      children: <Widget>[
        _disabledIndicator(),
        _activeIndicator(),
      ],
    );
  }

  Widget _activeIndicator() {
    return Opacity(
      opacity: ((_controller.value - 0.65) / 0.35).clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                _indicatorSize / 2 + _indicatorBlurRadius),
            boxShadow: [
              BoxShadow(
                color: widget.activatedColor,
                blurRadius: _indicatorBlurRadius,
                spreadRadius: _indicatorBlurRadius / 2,
              )
            ]),
        child: _buildIndicatorBulb(buttonBulbColor),
      ),
    );
  }

  Widget _disabledIndicator() {
    return _buildIndicatorBulb(widget.deactivatedColor);
  }

  Widget _buildIndicatorBulb(Color color) {
    return SizedBox(
      width: _indicatorSize,
      height: _indicatorSize,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(_indicatorSize / 2),
        ),
      ),
    );
  }
}
