import 'package:flutter/material.dart';
import 'package:marine_focus/util/timer/pomodoro_states.dart';
import 'package:marine_focus/util/timer/pomodoro_timer.dart';

/// Class to start a timer with already a time elapsed
class AlreadyStartedPomodoroTimer extends PomodoroTimer {
  final Duration initialDuration;

  AlreadyStartedPomodoroTimer({
    required this.initialDuration,
    super.pomodoroState,
    super.pomodoroTypes,
  });

  @override
  void start() {
    pomodoroState = PomodoroState.started;

    DateTime dateNow = DateTime.now().subtract(initialDuration);
    dateTimeRange = DateTimeRange(
      start: dateNow,
      end: dateNow.add(pomodoroTypes.duration),
    );
  }

  @override
  Duration get timeElapsed => (hasStarted)
      ? DateTimeRange(start: dateTimeRange.start, end: DateTime.now()).duration
      : initialDuration;
}
