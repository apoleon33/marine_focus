import 'package:flutter/material.dart';
import 'package:marine_focus/util/timer/pomodoro_states.dart';
import 'package:marine_focus/util/timer/pomodoro_types.dart';

class PomodoroTimer {
  final PomodoroTypes pomodoroTypes;

  PomodoroState pomodoroState = PomodoroState.notStarted;
  late DateTimeRange dateTimeRange;

  DateTime? _pauseDate;
  late DateTime startTime;

  void _initTimer() {
    startTime = DateTime.now();
    dateTimeRange = DateTimeRange(
      start: startTime,
      end: startTime.add(pomodoroTypes.duration),
    );
  }

  PomodoroTimer({required this.pomodoroTypes, pomodoroState}) {
    _initTimer();
    this.pomodoroState = pomodoroState ?? PomodoroState.notStarted;
  }

  /// Start the Pomodoro timer.
  void start() {
    pomodoroState = PomodoroState.started;
    _initTimer();
  }

  /// Pause the Pomodoro timer.
  void pause() {
    pomodoroState = PomodoroState.paused;
    _pauseDate = DateTime.now();
  }

  /// Resume the Pomodoro timer.
  /// Time has to have been paused before.
  void resume() {
    assert(_pauseDate != null);
    final pauseDuration = DateTime.now().difference(_pauseDate!);
    dateTimeRange = DateTimeRange(
      start: dateTimeRange.start.add(pauseDuration),
      end: dateTimeRange.end.add(pauseDuration),
    );
    pomodoroState = PomodoroState.started;
  }

  Duration get timeLeft => dateTimeRange.end.difference(DateTime.now());
}
