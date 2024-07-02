/// All existing states of a Pomodoro timer.
enum PomodoroState {
  notStarted,
  started,
  paused,
  cancelled,
  finished;

  @override
  String toString() => PomodoroState.values.indexOf(this).toString();
}
