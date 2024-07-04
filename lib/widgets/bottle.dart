import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marine_focus/util/duration_pretty_print.dart';
import 'package:marine_focus/widgets/animated_wave.dart';

import '../util/timer/pomodoro_timer.dart';

class Bottle extends StatefulWidget {
  const Bottle({super.key, required this.pomodoroTimer});

  final PomodoroTimer pomodoroTimer;

  @override
  State<StatefulWidget> createState() => _BottleState();
}

class _BottleState extends State<Bottle> {
  final double defaultContainerHeight = 24.0;
  final double maxLiquidHeight = 440.0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  /// Re-maps a number from one range to another.
  /// Stolen from the [Arduino doc](https://www.arduino.cc/reference/en/language/functions/math/map/).
  double _map(int x, int inMin, int inMax, int outMin, int outMax) {
    return (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }

  double get heightFromDuration {
    return _map(
      widget.pomodoroTimer.timeElapsed.inSeconds,
      0,
      widget.pomodoroTimer.pomodoroTypes.duration.inSeconds,
      defaultContainerHeight.toInt(),
      maxLiquidHeight.toInt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BorderSide borderDecoration = BorderSide(
      color: Theme.of(context).colorScheme.outline,
      width: 2.0,
    );
    const Radius radiusDecoration = Radius.circular(24.0);

    return Container(
      width: 300,
      height: 500,
      decoration: BoxDecoration(
        border: Border(
          left: borderDecoration,
          bottom: borderDecoration,
          right: borderDecoration,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: radiusDecoration,
          bottomRight: radiusDecoration,
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Column(
            verticalDirection: VerticalDirection.up,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(22.0),
                  bottomRight: Radius.circular(22.0),
                ),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 300,
                    height: heightFromDuration,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
              AnimatedWave(pomodoroState: widget.pomodoroTimer.pomodoroState),
            ],
          ),
          Column(
            children: [
              Text(
                widget.pomodoroTimer.timeLeft.prettyPrint(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                "Left",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
