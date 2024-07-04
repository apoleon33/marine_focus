import 'package:flutter/material.dart';
import 'package:marine_focus/util/timer/already_started_pomodoro_timer.dart';
import 'package:marine_focus/util/timer/pomodoro_states.dart';
import 'package:marine_focus/util/timer/pomodoro_types.dart';

class PomodoroTimer {
  late final PomodoroTypes pomodoroTypes;
  late PomodoroState pomodoroState;
  late DateTimeRange dateTimeRange;
  ValueNotifier<bool> isFinishedNotifier = ValueNotifier<bool>(false);

  PomodoroTimer({PomodoroState? pomodoroState, PomodoroTypes? pomodoroTypes}) {
    this.pomodoroState =
        (pomodoroState != null) ? pomodoroState : PomodoroState.notStarted;
    this.pomodoroTypes =
        (pomodoroTypes != null) ? pomodoroTypes : PomodoroTypes.pomodori;

    DateTime dateNow = DateTime.now();
    dateTimeRange = DateTimeRange(
      start: dateNow,
      end: dateNow.add(this.pomodoroTypes.duration),
    );
  }

  @mustCallSuper
  Duration get timeLeft {
    _actualisePomodoroState();
    return (hasStarted)
        ? dateTimeRange.end.difference(DateTime.now())
        : pomodoroTypes.duration;
  }

  @mustCallSuper
  Duration get timeElapsed {
    _actualisePomodoroState();
    return (hasStarted)
        ? DateTimeRange(start: dateTimeRange.start, end: DateTime.now())
            .duration
        : const Duration();
  }

  bool get isFinished {
    if (dateTimeRange.start
        .add(pomodoroTypes.duration)
        .isBefore(DateTime.now())) {
      pomodoroState = PomodoroState.finished;
    }
    return pomodoroState == PomodoroState.finished;
  }

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

  /// **Return** a new [PomodoroTimer] object with the previous time already elapsed.
  PomodoroTimer pause() => AlreadyStartedPomodoroTimer(
        initialDuration: timeElapsed,
        pomodoroTypes: pomodoroTypes,
        pomodoroState: PomodoroState.paused,
      );

  /// Check if [pomodoroState] is still relevant, or if the timer is finished.
  void _actualisePomodoroState() {
    isFinishedNotifier.value = isFinished;
  }

  @override
  String toString() {
    return 'PomodoroTimer{pomodoroTypes: $pomodoroTypes, pomodoroState: $pomodoroState, dateTimeRange: $dateTimeRange, isFinishedNotifier: $isFinishedNotifier}';
  }
}
