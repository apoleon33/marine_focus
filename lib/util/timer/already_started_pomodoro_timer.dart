import 'package:flutter/material.dart';
import 'package:marine_focus/util/cache/cache_manager.dart';
import 'package:marine_focus/util/duration_pretty_print.dart';
import 'package:marine_focus/util/timer/pomodoro_states.dart';
import 'package:marine_focus/util/timer/pomodoro_timer.dart';
import 'package:marine_focus/util/timer/pomodoro_types.dart';

class AlreadyStartedPomodoroTimer extends PomodoroTimer
    implements CacheManager<AlreadyStartedPomodoroTimer> {
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
  AlreadyStartedPomodoroTimer createFromCache(List<String> args) {
    final Duration initialDuration =
        DurationPrettyPrint.createFromPrettyPrint(args[0]);

    final PomodoroTypes pomodoroTypes =
        PomodoroTypes.values[int.parse(args[1])];

    return AlreadyStartedPomodoroTimer(
      initialDuration: initialDuration,
      pomodoroTypes: pomodoroTypes,
    );
  }

  @override
  List<String> toCache() => [
        initialDuration.prettyPrint(),
        pomodoroTypes.toString(),
      ];
}
