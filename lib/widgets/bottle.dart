import 'package:flutter/material.dart';
import 'package:marine_focus/util/timer/pomodoro_timer.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Bottle extends StatefulWidget {
  const Bottle({super.key, required this.pomodoroTimer});

  final PomodoroTimer pomodoroTimer;

  @override
  State<StatefulWidget> createState() => _BottleState();
}

class _BottleState extends State<Bottle> {
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
      0.85,
      0.86,
      0.88,
    ];
    return WaveWidget(
      config: CustomConfig(
        colors: colors,
        durations: durations,
        heightPercentages: heightPercentages,
      ),
      size: const Size(300, 400),
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
            child: Container(
              width: 300,
              height: 24,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          _createWave(context)
        ],
      ),
    );
  }
}
