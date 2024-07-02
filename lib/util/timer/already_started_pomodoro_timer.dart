import 'package:flutter/material.dart';
import 'package:marine_focus/util/duration_pretty_print.dart';
import 'package:marine_focus/util/timer/pomodoro_states.dart';
import 'package:marine_focus/util/timer/pomodoro_timer.dart';

class AlreadyStartedPomodoroTimer extends PomodoroTimer {
  final Duration initialDuration;

  /// Class to start a timer with already a time elapsed.
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
  Duration get timeLeft {
    super.timeLeft;
    return (hasStarted)
        ? dateTimeRange.end.difference(DateTime.now())
        : pomodoroTypes.duration - initialDuration;
  }

  @override
  Duration get timeElapsed {
    super.timeElapsed;
    return (hasStarted)
        ? DateTimeRange(start: dateTimeRange.start, end: DateTime.now())
            .duration
        : initialDuration;
  }

  @override
  List<String> toCache() {
    List<String> superCache = super.toCache();
    superCache[0] = initialDuration.prettyPrint();
    return superCache;
  }
}
