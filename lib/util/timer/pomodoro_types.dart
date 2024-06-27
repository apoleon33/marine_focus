/// With the pomodoro method there are 3 types of timer:
/// - [pomodoro]: 25 minutes where you do your task.
/// - [shortBreak]: A 5 min pause.
/// - [longBreak]: A 15 min pause.
enum PomodoroTypes {
  pomodori(Duration(minutes: 25)),
  shortBreak(Duration(minutes: 5)),
  longBreak(Duration(minutes: 15));

  /// Describes a singular pomodoro process.
  ///
  /// According to [Wikipedia](https://en.wikipedia.org/wiki/Pomodoro_Technique)
  /// the original technique has six steps:
  /// 1. Decide on the task to be done.
  /// 2. Set the Pomodoro timer (typically for 25 minutes).
  /// 3. Work on the task.
  /// 4. End work when the timer rings and take a short break (typically 5–10 minutes).
  /// 5. Go back to Step 2 and repeat until you complete four pomodoros.
  /// 6. After four pomodoros are done, take a long break (typically 20 to 30 minutes) instead of a short break. Once the long break is finished, return to step 2.
  static final List<PomodoroTypes> pomodoroSteps = [
    PomodoroTypes.pomodori,
    PomodoroTypes.shortBreak,
    PomodoroTypes.pomodori,
    PomodoroTypes.shortBreak,
    PomodoroTypes.pomodori,
    PomodoroTypes.shortBreak,
    PomodoroTypes.pomodori,
    PomodoroTypes.longBreak,
  ];

  final Duration duration;

  const PomodoroTypes(this.duration);
}
