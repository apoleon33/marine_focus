import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../util/timer/pomodoro_timer.dart';

class Bottle extends StatefulWidget {
  const Bottle({super.key, required this.pomodoroTimer});

  final PomodoroTimer pomodoroTimer;

  @override
  State<StatefulWidget> createState() => _BottleState();
}

class _BottleState extends State<Bottle> {
  final double defaultContainerHeight = 24.0;
  final double maxLiquidHeight = 455.0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (kDebugMode) print(widget.pomodoroTimer.timeElapsed.inSeconds);
      setState(() {});
    });
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

  Widget _createWave(BuildContext context) {
    List<Color> colors = [
      const Color.fromRGBO(0, 33, 49, 1.0),
      const Color.fromRGBO(0, 50, 75, 1.0),
      Theme.of(context).colorScheme.primaryContainer,
    ];

    const durations = [
      18000,
      8000,
      5000,
    ];

    const heightPercentages = [
      0.65,
      0.66,
      0.68,
    ];
    return WaveWidget(
      config: CustomConfig(
        colors: colors,
        durations: durations,
        heightPercentages: heightPercentages,
      ),
      size: const Size(300, 40),
      waveAmplitude: 0,
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
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(22.0),
              bottomRight: Radius.circular(22.0),
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 300,
                height: heightFromDuration,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
          _createWave(context),
          Text(
            widget.pomodoroTimer.timeLeft.prettyPrint(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}

extension DurationPrettyPrint on Duration {
  /// Small method to get the duration in the `mm:ss` format.
  String prettyPrint() {
    final List<String> dividedTime = toString().split(":");
    return "${dividedTime[1]}:${dividedTime[2].split(".")[0]}";
  }
}
