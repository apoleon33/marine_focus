import 'package:flutter/material.dart';
import 'package:marine_focus/util/timer/pomodoro_states.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AnimatedWave extends StatelessWidget {
  final PomodoroState pomodoroState;

  final double _defaultHeight = 40;

  final List<Color> colors = [
    const Color.fromRGBO(0, 33, 49, 1.0),
    const Color.fromRGBO(0, 50, 75, 1.0),
  ];

  final List<int> durations = [
    18000,
    8000,
    5000,
  ];

  final List<double> heightPercentages = [
    0.65,
    0.66,
    0.68,
  ];

  AnimatedWave({super.key, required this.pomodoroState});

  @override
  Widget build(BuildContext context) {
    colors.add(Theme.of(context).colorScheme.primaryContainer);
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: (pomodoroState == PomodoroState.started)
          ? AnimatedSize(
              duration: const Duration(milliseconds: 150),
              child: WaveWidget(
                config: CustomConfig(
                  colors: colors,
                  durations: durations,
                  heightPercentages: heightPercentages,
                ),
                size: Size(
                  300,
                  _defaultHeight,
                ),
                waveAmplitude: 0,
              ),
            )
          : const SizedBox(
              width: 0,
              height: 0,
            ),
    );
  }
}
