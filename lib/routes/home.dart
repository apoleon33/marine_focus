import 'package:flutter/material.dart';
import 'package:marine_focus/util/timer/already_started_pomodoro_timer.dart';
import 'package:marine_focus/util/timer/pomodoro_states.dart';
import 'package:marine_focus/util/timer/pomodoro_types.dart';
import 'package:marine_focus/widgets/bottle.dart';

import '../util/timer/pomodoro_timer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PomodoroTimer _pomodoroTimer;
  late ButtonState buttonState;
  int _pomodoroIndex = 0;

  @override
  void initState() {
    super.initState();

    buttonState = ButtonState.start;

    pomodoroTimer = AlreadyStartedPomodoroTimer(
      initialDuration: const Duration(minutes: 24, seconds: 45),
      pomodoroTypes: PomodoroTypes.pomodoroSteps[_pomodoroIndex],
    );

    pomodoroTimer.isFinishedNotifier.addListener(() {
      if (pomodoroTimer.isFinished) {
        setState(() {});
      }
    });
  }

  void _toggleButton() {
    if (buttonState == ButtonState.start || buttonState == ButtonState.resume) {
      pomodoroTimer.start();
    } else {
      pomodoroTimer = pomodoroTimer.pause();
    }
    setState(() {
      buttonState = buttonState.toggle;
    });
  }

  set pomodoroTimer(PomodoroTimer pomodoroTimer) {
    _pomodoroTimer = pomodoroTimer;
    // we need to re-create the isFinished listener for this new object
    _pomodoroTimer.isFinishedNotifier.addListener(() {
      if (pomodoroTimer.isFinished) {
        setState(() {});
      }
    });
  }

  PomodoroTimer get pomodoroTimer => _pomodoroTimer;

  void _changeTimer(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Timer Finished'),
            content: const Text('The timer has finished running.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });

    _pomodoroIndex = (_pomodoroIndex + 1) % PomodoroTypes.pomodoroSteps.length;
    pomodoroTimer = PomodoroTimer(
      pomodoroTypes: PomodoroTypes.pomodoroSteps[_pomodoroIndex],
      pomodoroState: PomodoroState.notStarted,
    );

    setState(() {
      buttonState = ButtonState.start;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pomodoroTimer.isFinished) {
      _changeTimer(context);
    }

    return Column(
      verticalDirection: VerticalDirection.down,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 26.0),
          child: Bottle(
            pomodoroTimer: pomodoroTimer,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 46.0),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (buttonState == ButtonState.resume) ...[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.errorContainer,
                        ),
                        child: Text(
                          ButtonState.stop.label,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
                Expanded(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 150),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                        onPressed: _toggleButton,
                        child: Text(buttonState.label),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

enum ButtonState {
  start("START TIMER"),
  stop("STOP TIMER"),
  pause("PAUSE TIMER"),
  resume("RESUME TIMER");

  final String label;

  const ButtonState(this.label);
}

extension ButtonStateExtension on ButtonState {
  ButtonState get toggle {
    switch (this) {
      case ButtonState.start:
        return ButtonState.pause;
      case ButtonState.pause:
        return ButtonState.resume;
      case ButtonState.stop:
        return ButtonState.start;
      case ButtonState.resume:
        return ButtonState.pause;
    }
  }
}
