import 'package:flutter/material.dart';
import 'package:marine_focus/util/timer/pomodoro_states.dart';
import 'package:marine_focus/util/timer/pomodoro_types.dart';

// TODO: add a way to pause and resume the timer.
class PomodoroTimer {
  late final PomodoroTypes pomodoroTypes;
  late PomodoroState pomodoroState;
  late DateTimeRange dateTimeRange;

  PomodoroTimer._init({
    required this.pomodoroState,
    required this.pomodoroTypes,
    required this.dateTimeRange,
  });

  /// Create a Pomodoro timer with already [elapsedTime] done.
  @Deprecated("It's litteraly not working")
  static PomodoroTimer customTimeElapsed({
    required Duration elapsedTime,
    PomodoroState? pomodoroState,
    PomodoroTypes? pomodoroTypes,
  }) {
    pomodoroState =
        (pomodoroState != null) ? pomodoroState : PomodoroState.notStarted;
    pomodoroTypes =
        (pomodoroTypes != null) ? pomodoroTypes : PomodoroTypes.pomodoro;

    DateTime dateNow = DateTime.now().subtract(elapsedTime);

    return PomodoroTimer._init(
      pomodoroState: pomodoroState,
      pomodoroTypes: pomodoroTypes,
      dateTimeRange: DateTimeRange(
        start: dateNow,
        end: dateNow.add(pomodoroTypes.duration),
      ),
    );
  }

  PomodoroTimer({PomodoroState? pomodoroState, PomodoroTypes? pomodoroTypes}) {
    pomodoroState =
        (pomodoroState != null) ? pomodoroState : PomodoroState.notStarted;
    pomodoroTypes =
        (pomodoroTypes != null) ? pomodoroTypes : PomodoroTypes.pomodoro;

    DateTime dateNow = DateTime.now();
    dateTimeRange = DateTimeRange(
      start: dateNow,
      end: dateNow.add(pomodoroTypes.duration),
    );
    this.pomodoroTypes = pomodoroTypes;
    this.pomodoroState = pomodoroState;

    PomodoroTimer._init(
      pomodoroState: pomodoroState,
      pomodoroTypes: pomodoroTypes,
      dateTimeRange: DateTimeRange(
        start: dateNow,
        end: dateNow.add(pomodoroTypes.duration),
      ),
    );
  }

  Duration get timeLeft => (hasStarted)
      ? dateTimeRange.end.difference(DateTime.now())
      : pomodoroTypes.duration;

  Duration get timeElapsed => (hasStarted)
      ? DateTimeRange(start: dateTimeRange.start, end: DateTime.now()).duration
      : const Duration();

  bool get hasStarted => pomodoroState == PomodoroState.started;

  /// Start the Pomodoro timer.
  void start() {
    pomodoroState = PomodoroState.started;

    // update when we are
    DateTime dateNow = DateTime.now();
    dateTimeRange = DateTimeRange(
      start: dateNow,
      end: dateNow.add(pomodoroTypes.duration),
    );
  }
}
