/// With the pomodoro method there are 3 types of timer:
/// - [pomodoro]: 25 minutes where you do your task.
/// - [shortBreak]: A 5 min pause.
/// - [longBreak]: A 15 min pause.
enum PomodoroTypes {
  pomodoro(Duration(minutes: 25)),
  shortBreak(Duration(minutes: 5)),
  longBreak(Duration(minutes: 15));

  final Duration duration;

  const PomodoroTypes(this.duration);
}
